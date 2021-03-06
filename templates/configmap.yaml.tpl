apiVersion: v1
kind: ConfigMap
metadata:
  name: "cloudmapper-config"
  namespace: "cloudmapper"
  labels:
    app: "cloudmapper"
    release: "__MANHEIM_CLOUDMAPPER_VERSION__"
data:
  ACCOUNT: __MANHEIM_CLOUDMAPPER_ACCOUNT__
  AWS_DEFAULT_REGION: __MANHEIM_CLOUDMAPPER_AWS_DEFAULT_REGION__
  AWS_REGION: __MANHEIM_CLOUDMAPPER_AWS_REGION__
  BOTO_MAX_ATTEMPTS: "__MANHEIM_CLOUDMAPPER_BOTO_MAX_ATTEMPTS__"
  OK_PORTS: __MANHEIM_CLOUDMAPPER_OK_PORTS__
  S3_BUCKET: __MANHEIM_CLOUDMAPPER_S3_BUCKET__
  SES_ENABLED: "__MANHEIM_CLOUDMAPPER_SES_ENABLED__"
  SES_RECIPIENT: __MANHEIM_CLOUDMAPPER_SES_RECIPIENT__
  SES_SENDER: __MANHEIM_CLOUDMAPPER_SES_SENDER__
