# k8s-cloudmapper
=================

#### TLDR:
Builds and schedules kubernetes cron job scans using cloudmapper docker image, creates AWS ECS repo if it doesn't already exist, pushes image to repo, then pulls down for scheduled cron kubernetes job.

- Should be deployed post terraform pre-requisites in the 
- - https://github.com/cmcconnell1/terraform-cloudmapper repo/project

### Overview:
##### Builds Internal myco image from Manheim Cloudmapper Docker project
  - This project/repository (in infrastructure automation code): 
    - builds, schedules, and deploys an internal cloudmapper Docker image post requisite Terraform module cloudmapper-terraform git repo project apply--which creates all requisite cloudmapper infrastructure) and schedules the cloudmapper kubernetes cronjob so it runs at the configured time. 
 - Emails results weekly (post runs) to the specified alias in TF vars (i.e.: sysadmin).
 - Used a k8s configmap and cron job.

### Docs
- For documentation on the upstream cloudmapper projects, please see 
  - https://github.com/duo-labs/cloudmapper (application code)
  - https://github.com/manheim/manheim-cloudmapper (dockerize / build project)

### Details
- Builds docker image and uploads to your AWS ECS repo: k8s/manheim-cloudmapper.
- Builds and deploys requisite kubernetes manfiests to cloudmapper namespace
  - installs cronjob scheduled run of cloudmapper weekly on Sunday at UTC 7AM / PDT 12 AM 
  - emails results to the specified recipient in the variables used to create the configmap

### Manual Runs
- This module schedules weekly executions of cloudmapper at the scheduled time (in TF vars file).
  - If we need to run cloudmapper manually you can do so
```console
./jobs/run-manual-job
```
which just does
```console
kubectl apply -f ./jobs/job.yaml -n cloudmapper
```

### Kube Validation
```console
k get all -n cloudmapper

NAME                        SCHEDULE     SUSPEND   ACTIVE   LAST SCHEDULE   AGE
cronjob.batch/cloudmapper   15 7 * * 6   False     0        <none>          40m
```

```console
k describe cronjob.batch/cloudmapper -n cloudmapper

Name:                          cloudmapper
Namespace:                     cloudmapper
Labels:                        <none>
Annotations:                   Schedule:  15 7 * * 6
Concurrency Policy:            Forbid
Suspend:                       False
Successful Job History Limit:  3
Failed Job History Limit:      1
Starting Deadline Seconds:     600s
Selector:                      <unset>
Parallelism:                   <unset>
Completions:                   <unset>
Active Deadline Seconds:       3600s
Pod Template:
  Labels:  <none>
  Containers:
   cloudmapper-crontab:
    Image:      01234567890.dkr.ECS.us-west-2.amazonaws.com/k8s/manheim-cloudmapper:0.2.5
    Port:       <none>
    Host Port:  <none>
    Command:
      /opt/manheim_cloudmapper/cloudmapper.sh
    Args:

    Environment Variables from:
      cloudmapper-config   ConfigMap  Optional: false
      cloudmapper-sECSets  SECSet     Optional: false
    Environment:           <none>
    Mounts:                <none>
  Volumes:                 <none>
Last Schedule Time:        <unset>
Active Jobs:               <none>
Events:                    <none>
```

- view job logs (could use pod logs too)
```console
k logs -f job.batch/cloudmapper-1593189300 -n cloudmapper
```
