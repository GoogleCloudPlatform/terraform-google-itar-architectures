#!/bin/sh

GCLOUD_LOCATION=$(command -v gcloud)
echo "Using gcloud from $GCLOUD_LOCATION"

gsutil rm -r gs://"$1"
gsutil kms authorize -k projects/"$5"/locations/"$2"/keyRings/"$3"/cryptoKeys/"$4" -p "$6"
# gcloud kms keys versions destroy 1 --location="$2" --keyring="$3" --key="$4" --project="$5"

