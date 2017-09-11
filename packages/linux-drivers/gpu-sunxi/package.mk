# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gpu-sunxi"
PKG_VERSION="r8p1-00rel0"
PKG_SHA256="0036796165612eea75bee0e756fbd50c3137be257d4739b91aad0c159ae4016a"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/products/software/mali-drivers/utgard-kernel"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-utgard-gpu/DX910-SW-99002-$PKG_VERSION.tgz"
PKG_SOURCE_DIR="DX910-SW-99002-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="gpu-sunxi: Linux drivers for Mali GPUs found in Allwinner SoCs"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

PKG_DRIVER_DIR=$PKG_BUILD/driver/src/devicedrv/mali/

make_target() {
  kernel_make -C $(kernel_path) M=$PKG_DRIVER_DIR MALI_PLATFORM_FILES=platform/sunxi/sunxi.c \
    EXTRA_CFLAGS="-DCONFIG_MALI_DVFS -DMALI_FAKE_PLATFORM_DEVICE=1 -DCONFIG_MALI_DMA_BUF_MAP_ON_ATTACH" \
    CONFIG_MALI400=m CONFIG_MALI_DVFS=y CONFIG_MALI400_DEBUG=y
}

makeinstall_target() {
  kernel_make -C $(kernel_path) M=$PKG_DRIVER_DIR \
    INSTALL_MOD_PATH=$INSTALL/$(get_kernel_overlay_dir) INSTALL_MOD_STRIP=1 DEPMOD=: \
    modules_install
}
