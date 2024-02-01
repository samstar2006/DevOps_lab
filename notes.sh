use terraform aws
    vpc
    jenkins ec2
    ansible controller ec2
    ansible managed nodes apache ec2
    ansible managed nodes docker ec2
    sonatype nexus ec2
    subnet
    internet gateway 
    security groups
    route table
    route table association

rtb-07315e2300bf7bac0
vpc-0e1fdb16662e4354a

chmod 600 EC2.pem
ssh -i EC2.pem ec2-user@3.129.216.246
whoami

sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins
sudo chkconfig jenkins on
sudo service jenkins status
go the the browser and enter your ec2 server ip you installed jenkins on with 8080 for example 18.188.197.125:8080

#delete the user data file we used to installed jenkins 
cd /var/lib/cloud/instances/i-026ab06d219b06e52
cat user-data.txt
rm -f user-data.txt

# to find user data log we used in our terraform script
cd /var/log
tail -300f cloud-init-output.log 
cat tail -300f cloud-init-output.log

# copy the jenkins password by going to
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
9cdc521b7e284199ade8fd8f0f40c7da
 ami-02b8534ff4b424939


to enable our AnsibleManagedNode to communicate with our AnsibleCN, we need to generate an ssh key on AnsibleCN and copy the key to AnsibleManagedNode,
ssh-keygen  
cd .ssh
go to the AnsibleManagedNode enter ip addr and press enter
copy  inet 172.20.10.60
go back to AnsibleCN and type ssh-copy-id 172.20.10.84
now to test if the ssh works ssh 172.20.10.84

systemctl start docker
systemctl status docker
docker --version
docker info
docker images
docker run hello-world
docker images

sonatype nexus
https://help.sonatype.com/repomanager3/product-information/download
service nexus status
https://www.youtube.com/watch?v=vo2FXvPkcEA
sudo systemctl status nexus

pom.xml is file used for maven

make sure the git repo is public and master
git status
git add .
git commit -m "my first commmit"
git push 
git remote 
git remote -v

######################################################
# make sure we have the followinf plugins installed: maven, publish over ssh, Pipeline Utility Steps,
# go to Managed Jenkins, Tool and add Maven
# create jenkins job
step 1
click new item
select freestyle
type FirstJob
enter the description
click add build step and select execute shell and type: echo "This is my first successful build" and click apply

step 2 
click on Build Now
click on dropdown arrow on #1 and select console output

#how to build maven_project
go to jenkins, click on new item 
enter name as maven_project and select Maven
enter the description: This is to build my first maven project
click on source code managemnet and select Git
go to github and copy https://github.com/samstar2006/DevOps_lab.git 
go to branches to build */master
go the Build and set goals and options "clean package install"
click apply and save

step 3 
click on Build Now
click on dropdown arrow on #1 and select console output
look for your project directory /var/lib/jenkins/workspace/Maven_project/target/VinayDevOpsLab

#step 4 
go back to the maven project
click on workspace
click on target to see build artifact

jenkinsfile is how you write declarative pipeline script
update pom.xml

#pipeline job
step 1
push it to github
go back to jenkins click on new item and name ot pipelinejob
select pipeline and click ok
description: there are 3 build lifecycle in maven:
    1. default; handles project deployment
    2. clean;   cleanin up the project
    3. site: creation of project's
goal: clean package install
parkage and install on the local repository
go to pipeline and select pipeline script from SCM
Click on SCM dropdown and git and paste your repo url
make sure it says jenkins file, click apply and save 
click on build now

#pOll SCM is anytime we make changes to our code, it will pull it automatically
got the pipelinejob
click on configure
got to build triggers 
check poll SCM
for schedule put * * * * * to poll every minute/ H * * * * every hour 
click apply and save

#How to publish artifact to sonatype nexus
step 1
login to sonatype ne
click on server adminstration and configuration 
click on repository
click create repository 
look for maven2 hosted

step 2
go back to managed jenkins
click on managed jenkins
click managed plugins
click available plugins and search for nexus artifact uploader
check it and click on install without install

step 3 
click on dashboard
click on pipelinejob
click on pipeline syntax
click on snippet generator
click the dropdown on sample step and select nexus artifact uploader
under nexus version select nexus 3
for Nexus url, copy the private ip of the nexus ec2 server 172.20.10.219:8081
enter the nexus username and passward for login, description type nexus and click add
select the credential you just addedd

step 4 
got to nexus site copy the repo name
got to pom.xml and copy the group id and version
click add under artifacts and copy the artifactid from the pom.xml 
    tpe: war
    classifer: leave blank
    file: target/artifactId-version
target/VinayDevOpsLab-0.0.4.war
click on generate pipeline script 

step 5
copy the snippet:
nexusArtifactUploader artifacts: [[artifactId: 'VinayDevOpsLab', classifier: '', file: 'target/VinayDevOpsLab-0.0.4.war', type: 'war']], credentialsId: '77c954e7-8fdd-4d1b-af59-a36d89094635', groupId: 'com.vinaysdevopslab', nexusUrl: '172.20.10.42:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-snapshots', version: '0.0.4'
go back to vscode add stage 3 to the jenkinsfile and paste the snippet for jenkins
go to pom.xml file and change the version to 0.0.5
go back to the jenkinsfile and change the snippet version to 0.0.5
push to hithub
go back to jenkins and click on pipelinejob and click build now
go to nexus and click on the square box

PIPELINE UTILITY Steps
installed pipeline Utility steps on jenkins if you did not install it already


// // worked maven project //
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
// // worked //


// worked for pipelinejob//

// pipeline {
//     //Directives
//     agent any
//     tools {
//         maven 'Maven'
//     }
//     environment {
//        ArtifactId = readMavenPom().getArtifactId()
//        Version = readMavenPom().getVersion()
//        Name = readMavenPom().getName()
//        GroupId = readMavenPom().getGroupId()
//     }
//     stages {
//         // stage 1. Build
//         stage ('Build') {
//             steps {
//                 sh 'mvn clean install package'
//             }
//         }

//         // Stage2 : Testing
//         stage ('Test') {
//             steps {
//                 echo ' testing......'
//             }
//         }
//     }
// }

// worked for pipepile//


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
