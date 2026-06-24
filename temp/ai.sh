mkdir -p ~/dev/llm
cd ~/dev/llm || exit
git clone --depth=1 https://github.com/ggml-org/llama.cpp && cd llama.cpp || exit
cmake -B build
cmake --build build --config Release -j"$(nproc)"
cd ~ || exit
