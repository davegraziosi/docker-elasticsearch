#!/bin/bash

set -e

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

export CLUSTER_NAME=${CLUSTER_NAME:-elasticsearch-default}
export NODE_MASTER=${NODE_MASTER:-true}
export NODE_DATA=${NODE_DATA:-true}
export HTTP_ENABLE=${HTTP_ENABLE:-true}
export MULTICAST=${MULTICAST:-false}
export CLOUD_ENABLE=${CLOUD_ENABLE:-false}

# Enable S3 backups
export S3_BUCKET=${S3_BUCKET:-}
export S3_REGION=${S3_REGION:-}
export S3_ACCESS_KEY=${S3_ACCESS_KEY:-}
export S3_SECRET_KEY=${S3_SECRET_KEY:-}

export NAMESPACE=${NAMESPACE:-default}
export DISCOVERY_SERVICE=${DISCOVERY_SERVICE:-elasticsearch-discovery}

if [ "$1" = 'elasticsearch' ]; then
	exec elasticsearch "$@"
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
