pipeline{
    agent any


    stages{
	stage('Check nginx service') {
	    steps{
		sh '''
		    cd scripts
		    chmod +x *.sh
		    ./check_service.sh nginx
		'''
	    }
	}
    }
}
