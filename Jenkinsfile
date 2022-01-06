pipeline{
     
     agent any
     environment{
         SERVER_CREDENTIALS = credentials('cockpit-credentials')
     }
     
     stages{

         stage("build"){

             steps{
                 echo 'application is building.....'
             }
         }

         stage("test"){
             when{  //executes steps in this stage only if the expression is true

                 expression{
                     env.BRANCH_NAME == 'main'
                 }   

             }
             steps{
                 echo 'application is testing.....'
             }
         }

         stage("deploy"){

             steps{
                 echo "deploying with credentials: ${SERVER_CREDENTIALS}"
                 echo 'application is deploying.....'
                 withCredentials(
                     [
                         usernamePassword(credentials: 'cockpit-credentials', usernameVariable: USER,  passwordVariable: PWD)
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
