/*
Copyright 2016 The Kubernetes Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package spotinst

import (
	"fmt"

	"github.com/golang/glog"
	apiv1 "k8s.io/api/core/v1"
	"k8s.io/apimachinery/pkg/api/resource"
	"k8s.io/autoscaler/cluster-autoscaler/cloudprovider"
	"k8s.io/autoscaler/cluster-autoscaler/config/dynamic"
	"k8s.io/autoscaler/cluster-autoscaler/utils/errors"
)

const CloudProviderName = "spotinst"

// CloudProvider implements CloudProvider interface.
type CloudProvider struct {
	manager *CloudManager
	groups  []*Group
}

// BuildCloudProvider builds CloudProvider implementation for Spotinst.
func BuildCloudProvider(manager *CloudManager, specs []string) (*CloudProvider, error) {
	glog.Info("Building Spotinst cloud provider")
	cloud := &CloudProvider{
		manager: manager,
		groups:  make([]*Group, 0),
	}
	for _, spec := range specs {
		if err := cloud.addNodeGroup(spec); err != nil {
			return nil, fmt.Errorf("could not register group with spec %s: %v", spec, err)
		}
	}
	return cloud, nil
}

func (c *CloudProvider) addNodeGroup(spec string) error {
	group, err := c.buildGroupFromSpec(spec)
	if err != nil {
		return fmt.Errorf("could not parse spec for node group: %v", err)
	}
	c.groups = append(c.groups, group)
	c.manager.RegisterGroup(group)
	glog.Infof("Node group added: %s", group.groupID)
	return nil
}

func (c *CloudProvider) buildGroupFromSpec(value string) (*Group, error) {
	spec, err := dynamic.SpecFromString(value, true)
	if err != nil {
		return nil, fmt.Errorf("failed to parse node group spec: %v", err)
	}
	group := &Group{
		manager: c.manager,
		groupID: spec.Name,
		minSize: spec.MinSize,
		maxSize: spec.MaxSize,
	}
	return group, nil
}

// Name returns name of the cloud c.
func (c *CloudProvider) Name() string {
	return CloudProviderName
}

// NodeGroups returns all node groups configured for this cloud c.
func (c *CloudProvider) NodeGroups() []cloudprovider.NodeGroup {
	out := make([]cloudprovider.NodeGroup, len(c.groups))
	for i, group := range c.groups {
		out[i] = group
	}
	return out
}

// NodeGroupForNode returns the node group for the given node.
func (c *CloudProvider) NodeGroupForNode(node *apiv1.Node) (cloudprovider.NodeGroup, error) {
	instanceID, err := extractInstanceId(node.Spec.ProviderID)
	if err != nil {
		return nil, err
	}
	return c.manager.GetGroupForInstance(instanceID)
}

// Pricing returns pricing model for this cloud provider or error if not available.
func (c *CloudProvider) Pricing() (cloudprovider.PricingModel, errors.AutoscalerError) {
	return nil, cloudprovider.ErrNotImplemented
}

// GetAvailableMachineTypes get all machine types that can be requested from the cloud provider.
// Implementation optional.
func (c *CloudProvider) GetAvailableMachineTypes() ([]string, error) {
	return []string{}, nil
}

// NewNodeGroup builds a theoretical node group based on the node definition provided.
func (c *CloudProvider) NewNodeGroup(machineType string, labels map[string]string, extraResources map[string]resource.Quantity) (cloudprovider.NodeGroup, error) {
	return nil, cloudprovider.ErrNotImplemented
}
