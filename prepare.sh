sudo apt-get update 
sudo apt-get install -y -qq bc bison build-essential ccache curl flex libncurses5-dev libssl-dev python3 python-is-python3 zip lzop libelf-dev dwarves gcc-aarch64-linux-gnu g++-aarch64-linux-gnu binutils-aarch64-linux-gnu gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabihf

# Define Workspace Path
export WORKSPACE="/home/runner/work/Kernel_Action_Builder/Kernel_Action_Builder"

# Add Toolchains to PATH
export PATH="$WORKSPACE/toolchains/clang-r383902b/bin:$WORKSPACE/toolchains/gcc/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu/bin:$PATH"

# Build Variables
export ARCH=arm64 SUBARCH=arm64
export CROSS_COMPILE="$WORKSPACE/toolchains/gcc/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-"
export CROSS_COMPILE_ARM32="$WORKSPACE/toolchains/gcc/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu/bin/arm-none-linux-gnueabihf-"
export CC="$WORKSPACE/toolchains/clang-r383902b/bin/clang"
export CLANG_TRIPLE=aarch64-linux-gnu-
export KBUILD_BUILD_USER="tmate" KBUILD_BUILD_HOST="actions"

# Source Paths (Added as requested)
export SRC="$WORKSPACE/kernel_a326b"
export OUT_DIR="$SRC/out"
export OUTPUT_DIR="$WORKSPACE/output"
export SUSFS_DIR="$WORKSPACE/susfs4ksu"
export ANYKERNEL_DIR="$WORKSPACE/AnyKernel3"

# Defconfig
export DEFCONFIG="a32x_defconfig"
mkdir -p "$OUT_DIR" "$OUTPUT_DIR"
