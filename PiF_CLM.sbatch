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
python -u python3 PiF_CLM.py --gen_model_path ../Llama-2-7b-chat-hf --tgt_model_path ../Mistral-7B-Instruct --opt_objective ASR --output_dir PiF_From_Llama-2-7B_To_Mistral-7B