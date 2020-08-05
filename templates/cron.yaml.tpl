# * * * * *  command to execute
# │ │ │ │ │
# │ │ │ │ │
# │ │ │ │ └───── day of week (0 - 6) (0 to 6 are Sunday to Saturday, or use names; 7 is Sunday, the same as 0)
# │ │ │ └────────── month (1 - 12)
# │ │ └─────────────── day of month (1 - 31)
# │ └──────────────────── hour (0 - 23)
# └───────────────────────── min (0 - 59)
#
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: cloudmapper
spec:
  schedule: "__MANHEIM_CLOUDMAPPER_CRON_SCHEDULE__"
  concurrencyPolicy: "Forbid"
  failedJobsHistoryLimit: 1
  startingDeadlineSeconds: 600 # 10 min
  jobTemplate:
    spec:
      backoffLimit: 0
      activeDeadlineSeconds: 3600 # 1hr
      template:
        spec:
          containers:
            - name: cloudmapper-crontab
              image: "01234567890.dkr.ecr.us-west-2.amazonaws.com/k8s/manheim-cloudmapper:__MANHEIM_CLOUDMAPPER_VERSION__"
              command: ["/opt/manheim_cloudmapper/cloudmapper.sh"]
              args: [""]
              envFrom:
              - configMapRef:
                  name: "cloudmapper-config"
              - secretRef:
                  name: "cloudmapper-secrets"
          restartPolicy: Never
