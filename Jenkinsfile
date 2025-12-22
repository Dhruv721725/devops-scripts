pipeline{
    agent any

    parameters{
	string(
	    name: 'SERVICE_NAME',
	    defaultValue: 'nginx',
	    description: 'service name to monitor'
	)
    }

    triggers {
	cron('*/1 * * * *')
    }

    stages{
	stage('Checkout code') {
	    steps{
		checkout scm
	    }		    
	}

	stage('Prepare scripts') {
            steps{
                sh '''
		    cd scripts
		    chmod +x *.sh
		'''
            }
        }

	stage('Check nginx service') {
	    steps{
		sh '''
		    cd scripts
		    ./check_service.sh nginx
		'''
	    }
	}
	
	stage('Check Nginx Error Logs') {
            steps{
                sh '''
		    cd scripts
		    ./check_nginx_errors.sh
		'''
            }
        }
	
	stage('Report') {
            steps{
                echo "Monitoring completed for service: ${SERVICE_NAME}"
            }
        }
    }
	
    post {
	success{
	    echo "✅ SUCCESS: ${SERVICE_NAME} is healthy"
	}
	failure{
	    echo "❌ FAILURE: ${SERVICE_NAME} has issues"
	}
	always{
	    echo "📌 Pipeline execution finished"
	}
    }
}
