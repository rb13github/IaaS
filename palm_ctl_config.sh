cat <<EOF >sudo  /root/palmctl_config.yaml
endpoint:
  cacertfile: ""
  clientcertfile: ""
  clientkeyfile: ""
  url: https://app.hybridcloudmesh.ibm.com/
log:
  file: ""
user:
  token: \$MESH_API_KEY
EOF
