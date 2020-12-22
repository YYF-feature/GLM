#! /bin/bash

# Change for multinode config

NUM_WORKERS=4
NUM_GPUS_PER_WORKER=8
MP_SIZE=1

source $1
DATESTR=$(date +"%m-%d-%H-%M")

#OPTIONS_NCCL="NCCL_DEBUG=info NCCL_IB_DISABLE=0 NCCL_SOCKET_IFNAME=bond0 NCCL_IB_GID_INDEX=3 NCCL_NET_GDR_LEVEL=0"
#HOST_FILE_PATH="/root/code/config/pre_hostfile"
OPTIONS_NCCL="NCCL_DEBUG=info NCCL_IB_DISABLE=0 NCCL_SOCKET_IFNAME=ib0 NCCL_NET_GDR_LEVEL=2"
HOST_FILE_PATH="/root/code/config/hostfile"

mkdir logs
run_cmd="${OPTIONS_NCCL} deepspeed --num_nodes ${NUM_WORKERS} --num_gpus ${NUM_GPUS_PER_WORKER} --hostfile ${HOST_FILE_PATH} pretrain_gpt2.py ${gpt_options}" 2>&1 | tee logs/log-${DATESTR}.txt
echo ${run_cmd}
eval ${run_cmd}

set +x