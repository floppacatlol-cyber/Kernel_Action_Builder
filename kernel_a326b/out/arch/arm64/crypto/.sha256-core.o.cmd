cmd_arch/arm64/crypto/sha256-core.o := /home/runner/work/Kernel_Action_Builder/Kernel_Action_Builder/toolchains/clang-r383902b/bin/clang -Wp,-MD,arch/arm64/crypto/.sha256-core.o.d -nostdinc -isystem /home/runner/work/Kernel_Action_Builder/Kernel_Action_Builder/toolchains/clang-r383902b/lib64/clang/11.0.2/include -I../arch/arm64/include -I./arch/arm64/include/generated  -I../include -I../drivers/misc/mediatek/include -I./include -I../arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi -I../include/uapi -I./include/generated/uapi -include ../include/linux/kconfig.h -D__KERNEL__ -Qunused-arguments -mlittle-endian -DKASAN_SHADOW_SCALE_SHIFT=3 -D__ASSEMBLY__ --target=aarch64-linux-gnu --prefix=/home/runner/work/Kernel_Action_Builder/Kernel_Action_Builder/toolchains/gcc/bin/aarch64-none-linux-gnu- --gcc-toolchain=/home/runner/work/Kernel_Action_Builder/Kernel_Action_Builder/toolchains/gcc -no-integrated-as -Werror=unknown-warning-option -fno-PIE -DCONFIG_AS_LSE=1 -DKASAN_SHADOW_SCALE_SHIFT=3 -DCC_HAVE_ASM_GOTO -Wa,-gdwarf-2   -c -o arch/arm64/crypto/sha256-core.o arch/arm64/crypto/sha256-core.S

source_arch/arm64/crypto/sha256-core.o := arch/arm64/crypto/sha256-core.S

deps_arch/arm64/crypto/sha256-core.o := \
  ../include/linux/compiler_types.h \
    $(wildcard include/config/have/arch/compiler/h.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \

arch/arm64/crypto/sha256-core.o: $(deps_arch/arm64/crypto/sha256-core.o)

$(deps_arch/arm64/crypto/sha256-core.o):
