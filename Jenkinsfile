pipeline {
    agent any


    stages {
		stage('Check Build') {
			steps {
				 echo 'The build is running fine'
				 sh 'ls'
				 echo "Current Working Directory: ${pwd()}"
			}
		 }
		 
		stage('Docker image and container cleanup') {
			steps {
				 script {
					 // To delete the existing image and running container
					 sh 'docker stop frontend || true'
					 sh 'docker rm frontend || true'
					 sh 'docker rmi frontend:latest || true'
					 
					 sh 'docker stop backend || true'
					 sh 'docker rm backend || true'
					 sh 'docker rmi backend:latest || true'
				 }
			}
		 }
	
	
        stage('Build Frontend Image') {
            steps {
                script {
                    sh 'docker build -t frontend:latest -f ./src/frontend/Dockerfile ./src/frontend'
                }
            }
        }

        stage('Build Backend Image') {
            steps {
                script {
                    sh 'docker build -t backend:latest -f ./src/backend/Dockerfile ./src/backend'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Assuming you have a Docker daemon running on Jenkins
                    sh 'docker run -d -p 80:80 --name frontend frontend:latest'
                    sh 'docker run -d -p 3000:3000 --name backend backend:latest'
                }
            }
        }
    }
}
