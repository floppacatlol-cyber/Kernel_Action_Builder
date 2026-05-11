sudo apt-get update 
sudo apt-get install -y c bison build-essential ccache curl flex libncurses5-dev libssl-dev python3 python-is-python3 zip lzop libelf-dev dwarves gcc-aarch64-linux-gnu g++-aarch64-linux-gnu binutils-aarch64-linux-gnu gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabihf
export PATH="/home/runner/work/Kernel_Action_Builder/Kernel_Action_Builder/toolchains/clang-r383902b/bin:/home/runner/work/Kernel_Action_Builder/Kernel_Action_Builder/toolchains/gcc/bin:$PATH"
export ARCH=arm64 SUBARCH=arm64
export CROSS_COMPILE=aarch64-none-linux-gnu-
export CROSS_COMPILE_ARM32=arm-none-linux-gnueabihf-
export CC=clang CLANG_TRIPLE=aarch64-linux-gnu-
export KBUILD_BUILD_USER="tmate" KBUILD_BUILD_HOST="actions"
