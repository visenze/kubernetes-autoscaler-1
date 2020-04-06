
// throttle concurrent build
properties([[$class: 'ThrottleJobProperty', categories: [], limitOneJobWithMatchingParams: false, maxConcurrentPerNode: 1, maxConcurrentTotal: 1, paramsToUseForLimit: '', throttleEnabled: true, throttleOption: 'project']])

library(identifier: "visenze-lib@${params['VISENZE_LIB_BRANCH'] ?: 'master'}", changelog: false)

pipeline {
  agent {
    label "${params.AGENT_LABEL ?: 'build'}"
  }

  options {
    ansiColor('xterm')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout([
          $class: 'GitSCM',
          branches: scm.branches,
          doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
          extensions: [
            [
              $class: 'CloneOption',
              noTags: true,
              reference: '',
              timeout: 60
            ],
            [
              $class: 'SubmoduleOption',
              disableSubmodules: false,
              parentCredentials: true,
              recursiveSubmodules: true,
              trackingSubmodules: true,
              reference: '',
              timeout: 60
            ],
            [$class: 'CleanBeforeCheckout']
          ],
          userRemoteConfigs: scm.userRemoteConfigs
        ])
      }
    }

    stage('Test') {
      when {
        expression {
          return canRun()
        }
      }
      steps {
        script {
          dir('cluster-autoscaler') {
            sh('make test-in-docker')
          }
        }
      }
    }

    stage('Compile') {
      when {
        expression {
          return canRun()
        }
      }
      steps {
        script {
          dir('cluster-autoscaler') {
            sh('make build-in-docker')
          }
        }
      }
    }

    stage('Docker') {
      when {
        expression {
          return canRun()
        }
      }
      steps {
        script {
          dir('cluster-autoscaler') {
            def version = sh(script: "grep ClusterAutoscalerVersion version/version.go",
                             returnStdout: true).split('"')[-2]
            def registry = 'visenze'
            withEnv([
              "REGISTRY=${registry}",
              "TAG=${version}"
            ]) {
              sh('make make-image')
              docker.withRegistry('', 'docker-hub-credential') {
                def image = docker.image("${registry}/cluster-autoscaler:${version}")
                image.push()
              }
            }
          }
        }
      }
    }
  }
}

def canRun() {
  return env.BRANCH_NAME.startsWith('release-') || env.BRANCH_NAME == 'master'
}