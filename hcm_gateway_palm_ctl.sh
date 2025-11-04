#!/bin/bash
set -euo pipefail
cd /root

TOKEN="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"

#List releases
LATEST_RELEASE_JSON=\$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer \$TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://github.ibm.com/api/v3/repos/swhaley/mesh-scripts/releases/latest)

PALMCTL_ASSET_ID=\$(echo "\$LATEST_RELEASE_JSON" | jq -r '.assets[] | select(.name == "palmctl") | .id')

#List release assets

#Get specific release assets
curl -L \
  -H "Accept: application/octet-stream" \
  -H "Authorization: Bearer \$TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  --output /usr/bin/palmctl \
  https://github.ibm.com/api/v3/repos/swhaley/mesh-scripts/releases/assets/\$PALMCTL_ASSET_ID

chmod 700 /usr/bin/palmctl
SECRET_NAME_FOR_MESH_API_KEY="rb_mesh_api_key"
#Get the Mesh API key from secrets manager
MESH_API_KEY=\$(aws secretsmanager get-secret-value --secret-id $SECRET_NAME_FOR_MESH_API_KEY --query SecretString --output text)

# Set environment variables
export PALMCTL_USER_TOKEN="\$MESH_API_KEY" #as backup, the config file should be enough
export PALMCTL_ENDPOINT_URL="https://app.hybridcloudmesh.ibm.com" #as backup, the config file should be enough
export PALMCTL_CONFIG_FILE="/root/palmctl_config.yaml" #This must be set because during the user data init process, \$HOME is unbound and palmctl will rely on that as a fallback

cat <<EOF > /root/palmctl_config.yaml
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
