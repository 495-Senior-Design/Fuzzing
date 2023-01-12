pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
                ./test.sh
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
