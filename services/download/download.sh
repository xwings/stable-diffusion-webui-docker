#!/usr/bin/env bash

set -Eeuo pipefail

# TODO: maybe just use the .gitignore file to create all of these
mkdir -vp /data/.cache \
  /data/embeddings \
  /data/config/ \
  /data/models/ \
  /data/models/Stable-diffusion \
  /data/models/GFPGAN \
  /data/models/RealESRGAN \
  /data/models/LDSR \
  /data/models/VAE \
  /data/models/ControlNet \
  /data/models/ESRGAN \
  /data/models/ScuNET \
  /data/models/BSRGAN 

echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file /docker/links.txt --dir /data/models --continue

git clone https://github.com/deforum-art/deforum-for-automatic1111-webui /data/config/auto/extensions/deforum-for-automatic1111-webui
git clone https://github.com/AlUlkesh/stable-diffusion-webui-images-browser /data/config/auto/extensions/stable-diffusion-webui-images-browser
git clone https://github.com/camenduru/stable-diffusion-webui-huggingface /data/config/auto/extensions/stable-diffusion-webui-huggingface
git clone https://github.com/camenduru/sd-civitai-browser /data/config/auto/extensions/sd-civitai-browser
git clone https://github.com/kohya-ss/sd-webui-additional-networks /data/config/auto/extensions/sd-webui-additional-networks
git clone https://github.com/Mikubill/sd-webui-controlnet /data/config/auto/extensions/sd-webui-controlnet
git clone https://github.com/fkunn1326/openpose-editor /data/config/auto/extensions/openpose-editor
git clone https://github.com/jexom/sd-webui-depth-lib /data/config/auto/extensions/sd-webui-depth-lib
git clone https://github.com/hnmr293/posex /data/config/auto/extensions/posex
git clone https://github.com/nonnonstop/sd-webui-3d-open-pose-editor /data/config/auto/extensions/sd-webui-3d-open-pose-editor
git clone https://github.com/camenduru/sd-webui-tunnels /data/config/auto/extensions/sd-webui-tunnels
git clone https://github.com/etherealxx/batchlinks-webui /data/config/auto/extensions/batchlinks-webui
git clone https://github.com/catppuccin/stable-diffusion-webui /data/config/auto/extensions/stable-diffusion-webui-catppuccin
git clone https://github.com/camenduru/a1111-sd-webui-locon /data/config/auto/extensions/a1111-sd-webui-locon
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui-rembg /data/config/auto/extensions/stable-diffusion-webui-rembg
git clone https://github.com/ashen-sensored/stable-diffusion-webui-two-shot /data/config/auto/extensions/stable-diffusion-webui-two-shot
git clone https://github.com/thomasasfk/sd-webui-aspect-ratio-helper /data/config/auto/extensions/sd-webui-aspect-ratio-helper
git clone https://github.com/tjm35/asymmetric-tiling-sd-webui /data/config/auto/extensions/asymmetric-tiling-sd-webui

echo "Checking SHAs..."

parallel --will-cite -a /docker/checksums.sha256 "echo -n {} | sha256sum -c"

cat <<EOF
By using this software, you agree to the following licenses:
https://github.com/AbdBarho/stable-diffusion-webui-docker/blob/master/LICENSE
https://github.com/CompVis/stable-diffusion/blob/main/LICENSE
https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/LICENSE.txt
https://github.com/invoke-ai/InvokeAI/blob/main/LICENSE
And licenses of all UIs, third party libraries, and extensions.
EOF
