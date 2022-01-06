pipeline{
     
     agent any
     environment{
         SERVER_CREDENTIALS = credentials('cockpit-credentials')
     }

    stages{
        stage('dependencies'){
                steps{
                    echo 'installing dependencies'
                    nodejs('NodeJS-17.3.0'){
                        sh 'npm install'
                        sh 'npm install --global mbt'
                        sh 'mbt --version'
                    }
                }
         }   
         stage("build"){

             steps{

                 echo 'application is building.....'
                 nodejs('NodeJS-17.3.0'){
                     sh 'mbt build -t ./'
                 }
                 
             }
         }

         stage("test"){
             when{  //executes steps in this stage only if the expression is true

                 expression{
                     env.BRANCH_NAME == 'main'
                 }   

             }
             steps{
                 echo "application is testing..... branch: ${env.BRANCH_NAME}"
                 nodejs('NodeJS-17.3.0'){
                        sh 'npm run test'
                    }
             }
         }

         stage("deploy"){

             steps{ 
                 echo "deploying with credentials: ${SERVER_CREDENTIALS}"
                 echo 'application is deploying.....'
                 sh 'cf --version'
                 withCredentials(
                     [
                         usernamePassword(credentialsId: 'cockpit-credentials', usernameVariable: 'USER',  passwordVariable: 'PWD')
                     ]){
                        echo "username: ${USER}, pwd: ${PWD}"     
                 }
             }
         } 

     }
     post{
        always{ // Executes always after all stages are completed 

                echo 'All stages are completed.' 
        }

        success{// Executes when after all stages are completed if there is stage that succee.

                echo 'All stages are completed successfully.' 
        }
        failure{// Executes when after all stages are completed if there is stage that fail.

                echo 'Some stage fail.' 

        }
    }
}
