pipeline {
    agent 'any'

    environment {
        KEY_PAIR = '/home/sally/Downloads/ec2-ssh.pem '
        SSH_KEY = '/home/sally/.ssh/id_rsa.pub'
    }

    stages {
        stage('Create Infrastructure') {
            steps {
                dir("terraform") {
                    withCredentials([usernamePassword(credentialsId: 'aws', passwordVariable: 'aws_secret_key', usernameVariable: 'aws_access_key')]) {
                        sh """
                            terraform init 
                            terraform apply -auto-approve -var='aws_access_key=${aws_access_key}' -var='aws_secret_key=${aws_secret_key}'
                        """    
                    }
                }
            }
        }

         stage('Install Docker') {
            steps {
                dir ("ansible") {
                    sh """
                        ansible-playbook install-docker.yml -i inventory.txt --user ec2-user --key-file ${KEY_PAIR}  -e "key=${SSH_KEY}"
                    """
                }
                
            }
        }
    }
}
