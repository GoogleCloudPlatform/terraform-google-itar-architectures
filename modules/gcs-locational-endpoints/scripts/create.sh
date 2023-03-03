#!/bin/sh

GCLOUD_LOCATION=$(command -v gcloud)
echo "Using gcloud from $GCLOUD_LOCATION"

gcloud --version
# gcloud kms keyrings create "$1" --location "$4" --project "$6"
# gcloud kms keys create "$2" --keyring "$1" --location "$4" --purpose "encryption" --project "$6"
gsutil kms authorize -k projects/"$6"/locations/"$4"/keyRings/"$1"/cryptoKeys/"$2" -p "$3"

gsutil -o"'"Credentials:gs_host="$3"-storage.googleapis.com"'" mb -b on -c standard -k projects/"$6"/locations/"$4"/keyRings/"$1"/cryptoKeys/"$2" -l "$4" -p "$3"  gs://"$5"
gsutil versioning set on gs://"$5"
gsutil lifecycle set "$7" gs://"$5"

# gsutil -o"'"Credentials:gs_host="$3"-storage.googleapis.com"'" mb -b on -c standard -k projects/"$7"/locations/"$4"/keyRings/"$1"/cryptoKeys/"$2" -l "$4" -p "$3"  gs://"$6"
# gsutil versioning set on gs://"$6"
# gsutil lifecycle set lifecycle.json gs://"$5"

#gsutil -o"'"Credentials:gs_json_host="$3"-storage.googleapis.com"'" mb -b on -c standard -k "$1" -l "$3" -p "$2"  gs://"$4"