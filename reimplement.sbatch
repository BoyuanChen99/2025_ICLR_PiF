#!/bin/bash

#SBATCH -q nvidia-xxl
#SBATCH -p nvidia
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=71:59:59
#SBATCH --mem=50GB
#SBATCH --job-name=PiF_reimplement

module purge

# Load the Conda module
source ~/.bashrc

# Activate your Conda environment
conda activate cipherword

# Lead to huggingface cache
export HF_HOME='/scratch/bc3194/huggingface_cache'

python3 PiF_MLM.py \
    --gen_model_path google-bert/bert-large-uncased \
    --tgt_model_path mistralai/Mistral-7B-Instruct-v0.2 \
    --att_file data/advsmall.txt \
    --opt_objective ASR+GPT \
    --output_dir PiF_From_Bert_To_Mistral-7B

# Call python script with the model variable
# python -u PiF_MLM.py\
#     --gen_model_path google-bert/bert-large-uncased \
#     --tgt_model_path meta-llama/Llama-2-13b-chat-hf \
#     --rank_model_path OpenAssistant/reward-model-deberta-v3-large-v2 \
#     --opt_objective ASR \
#     --att_file data/harmbench.txt \
#     --interation 20 \
#     --output_dir PiF_HB_FC \
#     --output_file 20.json \
#     --hf_cache_dir /scratch/bc3194/huggingface_cache
