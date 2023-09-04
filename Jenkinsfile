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
    }
}
