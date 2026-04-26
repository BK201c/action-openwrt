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

# Add feed sources (pin to openwrt-25.12 branch where applicable)
# Ensure official feeds are present so dependent packages resolve correctly
echo "src-git packages https://github.com/openwrt/packages.git;openwrt-25.12" >> "feeds.conf.default"
echo "src-git luci https://github.com/openwrt/luci.git;openwrt-25.12" >> "feeds.conf.default"
echo "src-git routing https://git.openwrt.org/feed/routing.git;openwrt-25.12" >> "feeds.conf.default"
echo "src-git telephony https://git.openwrt.org/feed/telephony.git;openwrt-25.12" >> "feeds.conf.default"
echo "src-git small https://github.com/kenzok8/small" >> "feeds.conf.default"
