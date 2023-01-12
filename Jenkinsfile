pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
                sh ('./test.sh')
            }
        }
    }
    post { 
        always { 
            cleanWs()
            dir("${env.WORKSPACE}@script") {
                deleteDir()
             }
        }
    }
}
