#!/bin/bash

##SBATCH -q nvidia-xxl
#SBATCH -p nvidia
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=71:59:59
#SBATCH --mem=50GB
#SBATCH --job-name=PiF-ITSR

module purge

# Load the Conda module
source ~/.bashrc

# Activate your Conda environment
conda activate cipherword

# Lead to huggingface cache
export HF_HOME='/scratch/bc3194/huggingface_cache'

# Call python script with the model variable
python3 PiF_MLM.py \
    --gen_model_path google-bert/bert-large-uncased \
    --tgt_model_path internlm/internlm2_5-20b-chat \
    --rank_model_path OpenAssistant/reward-model-deberta-v3-large-v2 \
    --att_file data/strongreject.txt \
    --opt_objective ASR+GPT \
    --output_dir IT_SR \
    --hf_cache_dir /scratch/bc3194/huggingface_cache
