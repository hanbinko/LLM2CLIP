MODEL=EVA02-CLIP-L-14-336
PRETRAINED=eva_clip
python -m torch.distributed.launch --nproc_per_node=8 \
	--use_env training/main.py \
        --enable-deepspeed \
        --grad-checkpointing \
        --name="T_vitl336_Rcc12mR_Rcc3m_4ep" \
        --save-frequency 1  \
        --zeroshot-frequency 1 \
        --report-to="tensorboard, wandb" \
        --wandb-project-name="LLM2CLIP" \
        --wandb-notes="EVA02-CLIP-L-14-336" \
        --train-data-list "data/cc3m/cc3m-train-{00..0287}.tar;data/cc12m/cc12m-train-{00..1001}.tar" \
        --train-num-samples-list 2873538  10000225 \
        --eval-data-file=training/eval_datasets.yaml \
        --imagenet-val=data/eval_data/imagenet/val.zip \
        --imagenet-val-text=data/eval_data/imagenet/val_map.txt \
        --imagenet-classname-feautres data/eval_data/imagenet/im_classname_llm_features.dpt \
        --pretrained=${PRETRAINED} \
        --dataset-resampled \
        --precision "fp16" \
        --warmup 0 \
        --batch-size=512 \
        --eval-batch-size=1024 \
        --log-every-n-steps 50 \
        --epochs=20 \
        --lr=1e-5 \
        --visual-lr=1e-5 \
        --text-lr=1e-5 \
        --wd=0.05 \
        --visual-wd=0.05 \
        --text-wd=0.05 \
        --ld=1.0 \
        --text-ld=1.01 \
        --visual-ld=0.85 \
        --grad-clip-norm=5.0 \
        --smoothing=0. \
        --workers=8 \
        --model=${MODEL} \
        --seed 4096 \
        --gather-with-grad \
        --local-loss \
        --force-custom-clip \
        --optimizer="ap_adamw" \
        --zero-stage=1 \
        --dataset-type "webdataset" 