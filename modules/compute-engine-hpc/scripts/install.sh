#!/bin/bash
curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh --also-install
sudo google_mpi_tuning --nosmt
sudo google_mpi_tuning --nomitigation
sudo google_install_mpi --intel_mpi
sudo yum install intel-psxe-runtime -y
source /opt/intel/psxe_runtime_2018.4.274/linux/mpi/intel64/bin/mpivars.sh
sudo google_install_mpitune
