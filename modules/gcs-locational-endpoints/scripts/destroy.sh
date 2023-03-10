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

gsutil rm -r gs://"$1"
gsutil rm -r gs://"$2"
# gsutil kms authorize -k projects/"$6"/locations/"$3"/keyRings/"$4"/cryptoKeys/"$5" -p "$7"
# gcloud kms keys versions destroy 1 --location="$3" --keyring="$4" --key="$5" --project="$6"

