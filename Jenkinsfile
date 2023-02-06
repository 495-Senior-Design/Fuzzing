pipeline {
    agent{label 'agent1'}
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
              //  sh ('mkdir output')
                sh ('./test.sh')
               // sh ('./AFL/afl-fuzz -x ./input/sshd.dict -i input -o output -M 0 -- ./sshd -d -e -p 2222 -r -f ./openssh-portable/sshd_config -i')
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
