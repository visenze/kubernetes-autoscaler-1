// throttle concurrent build
properties([[$class: 'ThrottleJobProperty', categories: [], limitOneJobWithMatchingParams: false, maxConcurrentPerNode: 1, maxConcurrentTotal: 1, paramsToUseForLimit: '', throttleEnabled: true, throttleOption: 'project']])

library(identifier: "visenze-lib@${params['VISENZE_LIB_BRANCH'] ?: 'master'}", changelog: false)

pipeline {
  agent {
    label "${params.AGENT_LABEL ?: 'pod'}"
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

    stage('Compile') {
      when {
        expression {
          return env.BRANCH_NAME.startsWith('release-') || env.BRANCH_NAME == 'master'
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
          return env.BRANCH_NAME.startsWith('release-') || env.BRANCH_NAME == 'master'
        }
      }
      steps {
        script {
          dir('cluster-autoscaler') {
            def version = sh(script: "grep ClusterAutoscalerVersion version.go",
                             returnStdout: true).split('"')[-2]
            withEnv([
              'REGISTRY=visenze',
              "TAG=${version}"
            ]) {
              sh('make make-image')
              sh('make push-image')
            }
          }
        }
      }
    }
  }
}
