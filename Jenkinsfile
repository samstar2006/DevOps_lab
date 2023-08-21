pipeline {
    // Directives
    agent any
    tools {
        maven 'maven'
    }
    environment {
        ArtifactId = readMavenPom().getArtifactId()
        Version = readMavenPom().getVersion()
        Name = readMavenPom().getName()
        GroupId = readMavenPom().getGroupId()
    }
    stages {
        // Stage 1. Build
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        // Stage 2: Testing
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        // Stage 3: Publish the artifacts to Nexus
        stage('Publish to Nexus') {
            steps {
                script {
                    def NexusRepo = Version.endsWith("SNAPSHOT") ? "VinaysDevOpsLab-SNAPSHOT" : "VinaysDevOpsLab-RELEASE"
                    nexusArtifactUploader artifacts: [
                        [artifactId: "${ArtifactId}",
                        classifier: '',
                        file: "target/${ArtifactId}-${Version}.war",
                        type: 'war']
                    ],
                    credentialsId: '35e9b26e-269a-4804-a70d-6b2ec7a608ce',
                    groupId: "${GroupId}",
                    nexusUrl: '54.242.76.56:8081',
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    repository: "${NexusRepo}",
                    version: "${Version}"
                }
            }
        }

        // Stage 4: Print some information
        stage('Print Environment variables') {
            steps {
                echo "Artifact ID is '${ArtifactId}'"
                echo "Version is '${Version}'"
                echo "GroupID is '${GroupId}'"
                echo "Name is '${Name}'"
            }
        }

        // Refactoring deployment to a separate function to avoid redundancy
        def deploy = { playbook ->
            echo "Deploying ...."
            sshPublisher(publishers: 
            [sshPublisherDesc(
                configName: 'Ansible_Controller', 
                transfers: [
                    sshTransfer(
                        cleanRemote:false,
                        execCommand: "ansible-playbook /opt/playbooks/${playbook} -i /opt/playbooks/hosts",
                        execTimeout: 120000
                    )
                ], 
                usePromotionTimestamp: false, 
                useWorkspaceInPromotion: false, 
                verbose: false
            )])
        }

        // Stage 5: Deploying the build artifact to Apache Tomcat
        stage('Deploy to Tomcat') {
            steps {
                script {
                    deploy("downloadanddeploy_as_tomcat_user.yaml")
                }
            }
        }

        // Stage 6: Deploying the build artifact to Docker
        stage('Deploy to Docker') {
            steps {
                script {
                    deploy("downloadanddeploy_docker.yaml")
                }
            }
        }
    }
}


// worked //
// pipeline {
//     agent any
//     tools {
//         maven 'maven'
//     }
//     environment {
//         ArtifactId = readMavenPom().getArtifactId()
//         Version = readMavenPom().getVersion()
//         Name = readMavenPom().getName()
//         GroupId = readMavenPom().getGroupId()
//     }
//     stages {
//         stage('Setup Env') {
//             steps {
//                 script {
//                     env.ARTIFACT_ID = sh(script: 'mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.artifactId -q -DforceStdout', returnStdout: true).trim()
//                     env.VERSION = sh(script: 'mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.version -q -DforceStdout', returnStdout: true).trim()
//                     env.NAME = sh(script: 'mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.name -q -DforceStdout', returnStdout: true).trim()
//                     env.GROUP_ID = sh(script: 'mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.groupId -q -DforceStdout', returnStdout: true).trim()
//                 }
//             }
//         }
//         stage('Build') {
//             steps {
//                 sh 'mvn clean install package'
//             }
//         }
//         stage('Test') {
//             steps {
//                 echo 'Testing...'
//             }
//         }
//         stage('Print Environment Variables') {
//             steps {
//                 echo "Artifact ID is '${env.ARTIFACT_ID}'"
//                 echo "Version is '${env.VERSION}'"
//                 echo "GroupID is '${env.GROUP_ID}'"
//                 echo "Name is '${env.NAME}'"
//             }
//         }
//     }
// }
// worked //