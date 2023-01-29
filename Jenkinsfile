pipeline {
    agent{label 'agent1'}
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
                sh ('./test.sh')
                sh ('./AFL/afl-fuzz -x ./input/sshd.dict -i input -o /run/user/1000/gvfs/smb-share:server=mycloud-2nln5u.local,share=public/FuzzOut -M 0 -- ./sshd -d -e -p 2222 -r -f ./openssh-portable/sshd_config -i')
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
