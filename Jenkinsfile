// worked maven project //
pipeline {
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
        stage('Setup Env') {
            steps {
                script {
                    env.ARTIFACT_ID = sh(script: 'mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.artifactId -q -DforceStdout', returnStdout: true).trim()
                    env.VERSION = sh(script: 'mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.version -q -DforceStdout', returnStdout: true).trim()
                    env.NAME = sh(script: 'mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.name -q -DforceStdout', returnStdout: true).trim()
                    env.GROUP_ID = sh(script: 'mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.groupId -q -DforceStdout', returnStdout: true).trim()
                }
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install package'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
        stage('Print Environment Variables') {
            steps {
                echo "Artifact ID is '${env.ARTIFACT_ID}'"
                echo "Version is '${env.VERSION}'"
                echo "GroupID is '${env.GROUP_ID}'"
                echo "Name is '${env.NAME}'"
            }
        }
    }
}
// worked //