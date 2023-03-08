#!/bin/bash
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

curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh --also-install
sudo google_mpi_tuning --nosmt
sudo google_mpi_tuning --nomitigation
sudo google_install_mpi --intel_mpi
sudo yum install intel-psxe-runtime -y
source /opt/intel/psxe_runtime_2018.4.274/linux/mpi/intel64/bin/mpivars.sh
sudo google_install_mpitune
