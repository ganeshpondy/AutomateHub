pipeline {
    agent { label 'EC2Agent' }
    tools {nodejs "node16" }
    environment {
        NODE_ENV='production'
    }
    
  
    stages {
       
        stage('source') {
            steps {
               git credentialsId: 'GitHub_GaneshPondy', url: 'https://github.com/ganeshpondy/aws_codebuild_codedeploy_nodeJs_demo.git'
               sh 'cat index.js'
               echo 'Source Stage'
            }
            
        }
        
         stage('build') {
             environment{
                 NODE_ENV='StagingGitTest'
             }
             
            
            steps {
             echo NODE_ENV
            //  withCredentials([string(credentialsId: 'e8f8ff88-49e0-433a-928d-36a518cd30d6', variable: 'secver')]) {
            //     // some block
            //     echo secver
            // }
            sh 'npm install'
            echo 'Build Stage'
            sh 'uptime; uname -a'
            // sh 'uname -z'    // Error Line
            }
            
        }
        
        //  stage('saveArtifact') {
        //     steps {
        //       archiveArtifacts artifacts: '**', followSymlinks: false
        //     }
            
        // }
        
        
        
    }

    post {
         always {
             echo 'This will always run'
         }
         success {
             echo 'This will run only if successful'
             mail bcc: '', body: "<b>successful</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: 'ganeshpondy@gmail.com', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Successful CI: Project name -> ${env.JOB_NAME}", to: "ganeshpondy@live.com";
         }
         failure {
             echo 'This will run only if Pipeline Failed'
             mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: 'ganeshpondy@gmail.com', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "ganeshpondy@live.com";
         }
         unstable {
             echo 'This will run only if the run was marked as unstable'
         }
     }
}
