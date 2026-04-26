#!/bin/bash
#
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add custom feed sources.
sed -i '$a src-git smpackage https://github.com/kenzok8/small-package' feeds.conf.default
