package gpumemory

import (
	apiv1 "k8s.io/api/core/v1"
	"k8s.io/apimachinery/pkg/api/resource"
	"k8s.io/autoscaler/cluster-autoscaler/cloudprovider"
	"k8s.io/autoscaler/cluster-autoscaler/utils/errors"
	"k8s.io/klog"
)

const (
	// ResourceVisenzeGPUMemory is the name of the GPU Memory resource
	ResourceVisenzeGPUMemory = "visenze.com/nvidia-gpu-memory"
	// GPULabel is the label added to nodes with GPU resource by Visenze.
	// If you're not scaling - this is probably the problem!
	GPULabel = "accelerator"
)

// NodeHasGpuMemory returns true if a given node has GPU hardware
func NodeHasGpuMemory(node *apiv1.Node) bool {
	_, hasGpuLabel := node.Labels[GPULabel]
	gpuAllocatable, hasGpuAllocatable := node.Status.Allocatable[ResourceVisenzeGPUMemory]
	return hasGpuLabel || (hasGpuAllocatable && !gpuAllocatable.IsZero())
}

// PodRequestsGpuMemory returns true if a given pod has GPU Memory request
func PodRequestsGpuMemory(pod *apiv1.Pod) bool {
	for _, container := range pod.Spec.Containers {
		if container.Resources.Requests != nil {
			_, gpuMemoryFound := container.Resources.Requests[ResourceVisenzeGPUMemory]
			if gpuMemoryFound {
				return true
			}
		}
	}
	return false
}

// RequestInfo gives some information about hwo much GPU memory is needed
type RequestInfo struct {
	MaximumMemory resource.Quantity
	TotalMemory   resource.Quantity
	Pods          []*apiv1.Pod
}

// GetGPUMemoryRequests returns information about how much memory is needed for a set of pods
func GetGPUMemoryRequests(pods []*apiv1.Pod) *RequestInfo {
	ri := &RequestInfo{}
	for _, pod := range pods {
		var podGpuMemory resource.Quantity
		for _, container := range pod.Spec.Containers {
			if container.Resources.Requests != nil {
				containerGpuMemory := container.Resources.Requests[ResourceVisenzeGPUMemory]
				podGpuMemory.Add(containerGpuMemory)
			}
		}
		if podGpuMemory.Value() == 0 {
			continue
		}

		if podGpuMemory.Cmp(ri.MaximumMemory) > 0 {
			ri.MaximumMemory = podGpuMemory
		}
		ri.TotalMemory.Add(podGpuMemory)
		ri.Pods = append(ri.Pods, pod)
	}
	return ri
}

// GetNodeTargetGpuMemory returns the gpu memory on a given node.
func GetNodeTargetGpuMemory(node *apiv1.Node, nodeGroup cloudprovider.NodeGroup) (gpuMemory int64, error errors.AutoscalerError) {
	//gpuLabel, found := node.Labels[GPULabel]
	//if !found {
	//	return  0, nil
	//}

	gpuMemoryAllocatable, found := node.Status.Allocatable[ResourceVisenzeGPUMemory]
	if found && gpuMemoryAllocatable.Value() > 0 {
		return gpuMemoryAllocatable.Value(), nil
	}

	// A node is supposed to have GPUs (based on label), but they're not available yet
	// (driver haven't installed yet?).
	// Unfortunately we can't deduce how many GPUs it will actually have from labels (just
	// that it will have some).
	// Ready for some evil hacks? Well, you won't be disappointed - let's pretend we haven't
	// seen the node and just use the template we use for scale from 0. It'll be our little
	// secret.

	if nodeGroup == nil {
		// We expect this code path to be triggered by situation when we are looking at a node which is expected to have gpus (has gpu label)
		// But those are not yet visible in node's resource (e.g. gpu drivers are still being installed).
		// In case of node coming from autoscaled node group we would look and node group template here.
		// But for nodes coming from non-autoscaled groups we have no such possibility.
		// Let's hope it is a transient error. As long as it exists we will not scale nodes groups with gpus.
		return 0, errors.NewAutoscalerError(errors.InternalError, "node without with visenze.com/nvidia-gpu-memory label, without capacity not belonging to autoscaled node group")
	}

	template, err := nodeGroup.TemplateNodeInfo()
	if err != nil {
		klog.Errorf("Failed to build template for getting GPU estimation for node %v: %v", node.Name, err)
		return  0, errors.ToAutoscalerError(errors.CloudProviderError, err)
	}
	if gpuMemoryCapacity, found := template.Node().Status.Capacity[ResourceVisenzeGPUMemory]; found {
		return gpuMemoryCapacity.Value(), nil
	}

	// if template does not define gpus we assume node will not have any even if ith has gpu label
	klog.Warningf("Template does not define gpus even though node from its node group does; node=%v", node.Name)
	return  0, nil
}
