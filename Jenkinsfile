pipeline {
    agent any

    triggers {
        cron('*/5 * * * *')
    }

    environment {
        SLACK_WEBHOOK = credentials('https://hooks.slack.com/services/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')
    }

    stages {
        stage('Check Nginx Errors') {
            steps {
                script {
                    def status = sh(
                        script: 'scripts/check_nginx_errors.sh',
                        returnStatus: true
                    )

                    if (status != 0) {
                        sh """
                        curl -X POST -H 'Content-type: application/json' \
                        --data '{"text":"🚨 *Nginx ERROR detected!*\\nCheck Jenkins job: ${env.JOB_NAME}"}' \
                        $SLACK_WEBHOOK
                        """
                        error("Nginx error found")
                    }
                }
            }
        }
    }

    post {
        success {
            sh """
            curl -X POST -H 'Content-type: application/json' \
            --data '{"text":"✅ Jenkins check passed. Nginx is healthy."}' \
            $SLACK_WEBHOOK
            """
        }
    }
}

