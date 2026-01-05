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

set -x
GCLOUD_LOCATION=$(command -v gcloud)
echo "Using gcloud from $GCLOUD_LOCATION"

gcloud --version
# gcloud kms keyrings create "$1" --location "$4" --project "$7"
# gcloud kms keys create "$2" --keyring "$1" --location "$4" --purpose "encryption" --project "$7"
# gcloud storage service-agent --authorize-cmek=projects/"$7"/locations/"$4"/keyRings/"$1"/cryptoKeys/"$2" --project "$3"

gcloud storage buckets create gs://"$5" --uniform-bucket-level-access --default-storage-class standard --default-encryption-key projects/"$7"/locations/"$4"/keyRings/"$1"/cryptoKeys/"$2" --location "$4" --project "$3"
# gcloud storage buckets update --versioning gs://"$5"
# gcloud storage buckets update --lifecycle-file=lifecycle.json gs://"$5"

# gcloud storage buckets create gs://"$6" --uniform-bucket-level-access --default-storage-class standard --default-encryption-key projects/"$7"/locations/"$4"/keyRings/"$1"/cryptoKeys/"$2" --location "$4" --project "$3"
# gcloud storage buckets update --versioning gs://"$6"
# gcloud storage buckets update --lifecycle-file=lifecycle.json gs://"$5"

#gcloud storage buckets create gs://"$4" --uniform-bucket-level-access --default-storage-class standard --default-encryption-key "$1" --location "$3" --project "$2"
