# TurboQuant + llama-swap (M1/M2/M3 Native)

This repository contains the configuration to run **TurboQuant** with **llama-swap** natively on macOS Apple Silicon (M1/M2/M3) using **Metal** acceleration.

## 🚀 Quick Start (New Mac Setup)

### 1. Prerequisites
Install Homebrew, then the required dependencies:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install cmake go
```

### 2. Clone and Build llama-server (Metal Support)
```bash
git clone https://github.com/devzhr/TurboQuant-llama-swap-MacOS.git
cd TurboQuant-llama-swap-MacOS

git clone --depth 1 -b feature/turboquant-kv-cache \
  https://github.com/TheTom/llama-cpp-turboquant.git

cd llama-cpp-turboquant
cmake -B build -DGGML_METAL=ON -DGGML_METAL_EMBED_LIBRARY=ON -DLLAMA_BUILD_SERVER=ON -DLLAMA_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release -j$(sysctl -n hw.ncpu)
cd ..
```

### 3. Install llama-swap
```bash
brew tap mostlygeek/llama-swap
brew install llama-swap
```

### 4. Download Model
Download a GGUF model (e.g., Qwen3.5-9B) and place it in the root folder.
*Recommended for 16GB RAM*: `Qwen2.5-7B-Instruct-Q8_0.gguf` or `Qwen3.5-9B-Instruct-Q4_K_M.gguf`.

### 5. Configure and Launch
Adjust the model path in `config.yaml`, then:
```bash
# Launch
llama-swap --config config.yaml --listen :18080

# Test
./verify.sh
```

## ⚠️ Memory Notes (OOM)
M1 with 16GB unified RAM can saturate quickly with 9B Q8_0 models (~9.5GB).
- **Stable Settings**: `-c 8192` (8K context)
- **Max Performance**: Use `-ngl 99` to force Metal GPU offloading.
- **If OOM occurs**: Reduce `-c` to `4096` or use a more quantized model (Q4).

## Included Files
- `config.yaml`: llama-swap configuration (Metal + TurboQuant).
- `verify.sh`: CURL test script.
- `.gitignore`: Excludes build folders and large model files.
