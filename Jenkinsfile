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

	    sh '''
		curl -X POST -H 'Content-type:application/json' \
		--data '{"text":"Failure detected"}' \
		https://hooks.slack.com/services/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
	    '''

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
	}
    }
}
