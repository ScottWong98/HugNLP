# path=/wjn/pre-trained-lm/gpt2
# path=/wjn/pre-trained-lm/gpt2-medium
path=/wjn/pre-trained-lm/gpt2-large
# path=/wjn/pre-trained-lm/gpt2-xl


model_name=gpt2

# the data example is shown in ./datasets/data_example/instruction/
# we provide an instruction-tuning medical trainin data.
# the training data can be downloaded by run 'bash download_example.sh'
# you can merge all data to form a final train.json and dev.json. the test.json is the same as dev.json.
# data_path=/wjn/nlp_task_datasets/instruction/all # 500,000
data_path=/wjn/nlp_task_datasets/instruction/instruction_corpora # 8,000,000 example, 160k group block

# export CUDA_VISIBLE_DEVICES=0,1,2,3
# python3 -m torch.distributed.launch --nproc_per_node=4 --master_port 6013 hugnlp_runner.py \
# --model_name_or_path=$path \
# --data_dir=$data_path \
# --max_seq_length=512 \
# --output_dir=./output/instruction/casual_lm_$model_name/ \
# --do_train \
# --do_eval \
# --do_predict \
# --per_device_train_batch_size=4 \
# --per_device_eval_batch_size=1 \
# --evaluation_strategy=steps \
# --save_strategy=steps \
# --gradient_accumulation_steps=2 \
# --learning_rate=1e-05 \
# --logging_steps=10000000 \
# --save_steps=1000 \
# --eval_steps=1000 \
# --save_total_limit=2 \
# --num_train_epochs=5 \
# --report_to=none \
# --task_name=causal_instruction \
# --task_type=causal_lm \
# --model_type=gpt2 \
# --exp_name=causal-instruciton \
# --warmup_steps=1000 \
# --ignore_data_skip \
# --remove_unused_columns=False \
# --cache_dir=/wjn/.cache \
# --overwrite_output_dir



export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
python3 -m torch.distributed.launch --nproc_per_node=8 --master_port 6013 hugnlp_runner.py \
--model_name_or_path=$path \
--data_dir=$data_path \
--max_seq_length=512 \
--output_dir=./outputs/instruction/casual_lm_$model_name/ \
--do_train \
--per_device_train_batch_size=2 \
--per_device_eval_batch_size=1 \
--evaluation_strategy=no \
--save_strategy=steps \
--gradient_accumulation_steps=2 \
--learning_rate=2e-05 \
--logging_steps=10000000 \
--save_steps=6000 \
--save_total_limit=10 \
--num_train_epochs=10 \
--report_to=none \
--task_name=causal_instruction \
--task_type=causal_lm \
--model_type=gpt2 \
--exp_name=causal-instruciton \
--warmup_steps=5000 \
--ignore_data_skip \
--remove_unused_columns=False \
--cache_dir=/wjn/.cache \
--overwrite_output_dir \
