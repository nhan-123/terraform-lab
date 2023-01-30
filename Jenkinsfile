pipeline {
   agent any

  tools {
    terraform 'terraform'
  }

  // environment {
  //   AWS_ACCESS_KEY_ID     = credentials('aws-secret-key-id')
  //   AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
  // }

  stages {
    // stage('get cred') {
    //   steps {
    //     withVault(configuration: [timeout: 60, vaultCredentialId: 'vault-jenkins-role', vaultUrl: 'http://192.168.56.109:8200'], vaultSecrets: [[path: 'ui/vault/secrets', secretValues: [[vaultKey: 'ec2-role']]]]){
    //       sh 'echo $secretValues'
    //     }
    //   }    
    // }
    stage('Init Provider') {
      steps {
        sh 'terraform init'
      }
    }
    stage('Plan Resources') {
      steps {
        sh 'terraform plan'
      }
    }
    stage('Apply Resources') {
      input {
        message "Do you want to proceed for production deployment?"
      }
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
  }
}