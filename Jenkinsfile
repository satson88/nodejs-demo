pipeline {
    agent any

    environment {
        registry = "satson88"  // Replace with your Docker registry URL
        DOCKERHUB_CREDENTIALS= credentials('docker-satson88')
        imageName = "nodejs-demo"  // Replace with your desired image name
        containerName = "nodejs-app-container"  // Replace with your desired container name
        dockerfilePath = "./Dockerfile"  // Replace with the path to your Dockerfile
        dockerArgs = "-p 3000:3000"  // Replace with your desired container arguments
        version = sh(script: 'jq \'.version\' package.json', returnStdout: true).trim()
    }
    stages {
        stage('Clean WS') { 
            steps { 
                cleanWs()
            }
        }
        stage('SCM'){
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/satson88/nodejs-demo.git']])
            }
        }
        
        stage('Docker Login') {
            steps {
                   sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'     		 
                }
            }
        

        stage('Build') {
            steps {
                
                sh "sudo docker build -t ${registry}/${imageName}:${version} -f ${dockerfilePath} ."
            }
        }
        
        stage('Push to Artifcatory') {
            steps {
                sh "sudo docker push ${registry}/${imageName}:${version}"
            }
        }
 /*
         stage('Code Analysis') {
            steps {
                sh "/opt/sonar-scanner/bin/sonar-scanner \
                    -Dsonar.projectKey=demo-nodejs \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://sonar.manolabs.co.in:9000 \
                    -Dsonar.login=sqp_d5fbbdfcf09bc49b5e9a0edb89639fc66aa45993"
            }
        } 

        stage('Deploy') {
            steps {
                 sh '''
                ssh root@10.0.1.205 <<  EOF
                
                docker rm  -f ${containerName} 1> /dev/null 2>&1

                sleep 5

                docker run -d --name ${containerName} ${dockerArgs} ${registry}/${imageName}:${version}

                exit

                EOF

                '''
            }
        } 
      */  
        stage('Deploy') {
            steps {
                 sh '''
                 export KUBECONFIG=/var/lib/jenkins/kubeconfig

                 sed "s/{{theVersion}}/$version/g" resources/deployment.yaml > deployment-amend.yaml

                 kubectl apply -f deployment-amend.yaml
                 
                 kubectl apply -f resources/service.yaml
                 
                 '''
    }
    
        }
    }
}