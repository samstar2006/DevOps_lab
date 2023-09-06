// worked for pipelinejob//

pipeline {
    //Directives
    agent any
    tools {
        maven 'Maven'
    }
    environment {
       ArtifactId = readMavenPom().getArtifactId()
       Version = readMavenPom().getVersion()
       Name = readMavenPom().getName()
       GroupId = readMavenPom().getGroupId()
    }
    stages {
        // stage 1. Build
        stage ('Build') {
            steps {
                sh 'mvn clean install package'
            }
        }

        // Stage2 : Testing
        stage ('Test') {
            steps {
                echo ' testing......'
            }
        }

        // stage 3 Publish the artifact to Nexus
         stage ('Publish to Nexus') {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'VinayDevOpsLab', classifier: '', file: 'target/VinayDevOpsLab-0.0.5.war', type: 'war']], credentialsId: '77c954e7-8fdd-4d1b-af59-a36d89094635', groupId: 'com.vinaysdevopslab', nexusUrl: '172.20.10.42:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-snapshots', version: '0.0.4'
            }
        }

        // Stage3 : Deploying
        stage ('Deploy') {
            steps {
                echo ' deploying......'
            }
        }
    }
}

// worked for pipepile//
