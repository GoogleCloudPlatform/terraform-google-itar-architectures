#!/bin/sh
# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


GCLOUD_LOCATION=$(command -v gcloud)
echo "Using gcloud from $GCLOUD_LOCATION"

gcloud --version
# gcloud kms keyrings create "$1" --location "$4" --project "$7"
# gcloud kms keys create "$2" --keyring "$1" --location "$4" --purpose "encryption" --project "$7"
gsutil kms authorize -k projects/"$7"/locations/"$4"/keyRings/"$1"/cryptoKeys/"$2" -p "$3"

gsutil 'Credentials:gs_json_host=us-central1-storage.googleapis.com' mb -b on -c standard -k projects/"$7"/locations/"$4"/keyRings/"$1"/cryptoKeys/"$2" -l "$4" -p "$3"  gs://"$5"
gsutil versioning set on gs://"$5"
gsutil lifecycle set lifecycle.json gs://"$5"

gsutil 'Credentials:gs_json_host=us-central1-storage.googleapis.com' mb -b on -c standard -k projects/"$7"/locations/"$4"/keyRings/"$1"/cryptoKeys/"$2" -l "$4" -p "$3"  gs://"$6"
gsutil versioning set on gs://"$6"
gsutil lifecycle set lifecycle.json gs://"$5"

#gsutil -o"'"Credentials:gs_json_host="$3"-storage.googleapis.com"'" mb -b on -c standard -k "$1" -l "$3" -p "$2"  gs://"$4"
