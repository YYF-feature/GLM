#! /bin/bash

script_path=$(realpath $BASH_SOURCE)
script_dir=$(dirname $script_path)

config_json="$script_dir/config_blockta_large.json"
gpt_options=" \
       --block-lm \
       --bert-prob 1.0 \
       --experiment-name blocklm-roberta-large-blank \
       --model-parallel-size ${MP_SIZE} \
       --num-layers 24 \
       --hidden-size 1024 \
       --num-attention-heads 16 \
       --seq-length 512 \
       --max-position-embeddings 512 \
       --save /root/data/checkpoints \
       --train-iters 500000 \
       --resume-dataloader \
       --train-data wikibook openwebtext cc-news \
       --lazy-loader \
       --tokenizer-type GPT2BPETokenizer \
       --tokenizer-model-type roberta \
       --split 949,50,1 \
       --distributed-backend nccl \
       --lr-decay-style linear \
       --lr-decay-iters 500000 \
       --lr-decay-ratio 0.025 \
       --warmup .06 \
       --checkpoint-activations \
       --deepspeed-activation-checkpointing \
       --fp16 \
"
gpt_options="${gpt_options}
               --deepspeed \
               --deepspeed_config ${config_json} \
"