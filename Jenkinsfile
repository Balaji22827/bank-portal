pipeline {
    agent any
    
    environment {
        
        my_reponame = "github"
        //make sure you add the credentials in jenkins>manage jenkins>credentials 
        password_docker = credentials('password_docker')
        
    }

    stages {
        
        stage('git checkout') {
            steps {
                git branch: "master", 
                url: 'https://github.com/Balaji22827/bank-portal.git'
                
            }
        }
        
        stage('check files') {
            steps {
                sh "ls -lrt"
                
            }
        }
        
        stage('build the source code') {
            steps { script{
               // sh "ls -lrt"
                def maven_path = tool (name: 'mvn_381', type: 'maven') + "/bin/mvn"
                sh "$maven_path -v"
                sh "$maven_path clean install"
            }}
        }
        
        stage('list the files after build') {
            steps { 
                script{
                    sh "ls -lrt"
                }
            }
        }
        
        stage('docker build') {
            steps { 
                script{
                    sh "docker build -t balajimo195/myapp:vv_${BUILD_NUMBER} ."
                }
            }
        }  
        
        stage('docker login and push image') {
            steps { 
                script{
                    sh "docker login -u balajimo195 -p ${password_docker}"
                    sh "docker push balajimo195/myapp:vv_${BUILD_NUMBER}"
                }
            }
        }
        
        stage('docker run image') {
            steps { 
                script{
                    
                    //the below two commands will work only if the container is already running
                    sh "docker stop mybank-app"
                    sh "docker rm mybank-app"
                    
                    sh " docker run -d --name mybank-app -p 9080:9080 balajimo195/myapp:vv_${BUILD_NUMBER}"
                    sleep 60
                    echo "end"
                }
            }
        }
        
        
        
    }
}
