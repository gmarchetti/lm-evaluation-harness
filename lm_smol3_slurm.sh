#!/bin/bash
#SBATCH --nodes=1
#SBATCH --gpus=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=1:00:00
#SBATCH --partition normal-a100-40
#SBATCH --gpus=1
#SBATCH --account=f202500007hpcvlabuportog ##should end in G

singularity run /projects/F202500007HPCVLABUPORTO/gmarchetti/lm-harness.sif lm_eval \
--model hf \
--model_args pretrained=HuggingFaceTB/SmolLM3-3B,enable_thinking=True,think_end_token="</think>",think_start_token="<think>" \
--tasks mmlu_pro,gpqa_diamond_cot_zeroshot \
--device cuda:0 \
--log_samples \
--batch_size=1 \
--output_path /projects/F202500007HPCVLABUPORTO/gmarchetti/results/smol3b \
--gen_kwargs temperature=0.6,top_p=0.95,top_k=20,do_sample=True,max_length=4000 \
--limit=20 \
--apply_chat_template