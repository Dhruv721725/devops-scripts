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
    environment {
	SCRIPTS_DIR = "scripts"
    }
    options {
	timeout(time: 2, unit: 'MINUTES')
    }

    stages{
	stage('Checkout') {
	    steps{
		checkout scm
	    }		    
	}

	stage('Prepare') {
            steps{
                sh '''
		    cd scripts
		    chmod +x *.sh
		'''
            }
        }

	stage('Health Check') {
            steps{
                sh '''
                    cd $SCRIPTS_DIR
                    ./check_service.sh ${SERVICE_NAME}
                '''
            }
        }

	stage('Check Nginx Error Logs') {
	    when {
		expression { params.SERVICE_NAME == 'nginx'}
	    }
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
	    echo "🔔 Immediate attention required"

	    emailext(
		subject: "🚨 ALERT: ${SERVICE_NAME} DOWN on Jenkins",
		body: """
		    <h2>Service Down Alert</h2>
		    <p><b>Service:</b> $SERVICE_NAME</p>
                    <p><b>Job:</b> ${env.JOB_NAME}</p>
                    <p><b>Build:</b> #${env.BUILD_NUMBER}</p>
                    <p><b>Status:</b> FAILED</p>
                    <p><a href="${env.BUILD_URL}">View Build Logs</a></p>
		""",
		to: "dhruv721725@gmail.com"
	    )
	}
	always{
	    echo "Monitoring run complted at ⏱  ${new Date()} "
	    emailext(
		subject: "Alert jenkins pipeline is working",
		body: "Alert for informing about jenkin is executing pipeline",
		to: "dhruv721725@gmail.com"
	    )
	}
    }
}
