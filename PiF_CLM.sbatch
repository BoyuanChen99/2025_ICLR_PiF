#!/bin/bash

#SBATCH -q ebrainccs
#SBATCH -p nvidia
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=71:59:59
#SBATCH --mem=50GB
#SBATCH --job-name=PiF

module purge

# Load the Conda module
source ~/.bashrc

# Activate your Conda environment
conda activate cipherword

# Lead to huggingface cache
export HF_HOME='/scratch/bc3194/huggingface_cache'

# Call python script with the model variable
python -u PiF_CLM.py\
    --gen_model_path meta-llama/Llama-2-7b-chat-hf\
    --tgt_model_path tiiuae/Falcon3-10B-Instruct\
    --att_file data/jailbreakbench.txt\
    --opt_objective ASR+GPT\
    --output_dir PiF_From_JBB
