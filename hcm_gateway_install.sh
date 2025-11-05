# Run palmctl install gateway
echo "Installing gateway"

palmctl install gateway -v 3 -f - <<EOF
gateway_name: $MESH_GATEWAY_NAME
delete_existing_gateway_resource: true
secondary_ips_config:
  secondary_ips: $SECONDARY_IPS_JSON
inbound_linking_config: 
  advertised_ip: "$PUBLIC_IP"
  private_ip: "$PRIMARY_PRIVATE_IP"
microk8s_config:
  channel: "1.33/stable"
  image_registry_url: "icr.io/container-registry-develop"
  image_registry_username: "iamapikey"
  image_registry_password: "QfVWfLf-Mg_AlX2IgYsTEatEsuGDrqZBqc4S_MNGbTWo"
  calico_kube_controllers_image: "icr.io/container-registry-develop/kube-controllers:v3.28.1"
  calico_node_image: "icr.io/container-registry-develop/node:v3.28.1"
  calico_cni_image: "icr.io/container-registry-develop/cni:v3.28.1"
  coredns_image: "icr.io/container-registry-develop/coredns:1.10.1"
  hostpath_provisioner_image: "icr.io/container-registry-develop/hostpath-provisioner:1.5.0"
  hostpath_busybox_image: "icr.io/container-registry-develop/busybox:1.28.4"
  storage_class: "microk8s-hostpath"
deploy_gateway_config:
  network_segment:
    name: "$NETWORK_SEGMENT_NAME"
    compatibility_set: RHSI
  cloud:
    name: "$AUTODEPLOY_CLOUD_NAME"
    type: "$AUTODEPLOY_CLOUD_TYPE"
  location:
    name: "$AUTODEPLOY_LOCATION_NAME"
    type: region
    city: "$AUTODEPLOY_LOCATION_CITY"
    country: "$AUTODEPLOY_LOCATION_COUNTRY"
    administrative_region: "$AUTODEPLOY_LOCATION_ADMIN_REGION"
    geo_coordinates: "$AUTODEPLOY_LOCATION_COORDS"
  cluster:
    name: "$AUTODEPLOY_CLUSTER_NAME"
    type: SINGLE-NODE-K8S
  gateway:
    intended_compute_profile: small
    external_client_access: loadbalancer
    ip_address_pool: "$SECONDARY_IPS_CIDR"
EOF

