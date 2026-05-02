# Actions-OpenWrt

A customized OpenWrt firmware for x86_64 routers, built with GitHub Actions.

## Usage

This repository provides a customized OpenWrt firmware build for x86_64 routers with pre-configured packages and drivers.

- Fork this repository.
- Edit `packages.txt` to manage included packages.
- Push changes and run the fast workflow from Actions.
- Download the built firmware from workflow artifacts.

## Workflows

- `OpenWrt Fast Build (ImageBuilder)`: default and recommended workflow on `main`.
- `Update Checker`: checks upstream OpenWrt updates and triggers repository_dispatch.

The source-build workflow and related files have been moved to the `source` branch.

## Supported Hardware

This firmware includes drivers for the following network interfaces:

- **Intel IGC**: 2.5G/10G Ethernet controllers
- **Realtek RTL8169**: 1G Ethernet controllers (e.g., RTL8111H)
- **Realtek RTL8188EE**: Wireless 802.11b/g/n adapters

## Third-party Package Feeds

PassWall2 is installed from the signed APK repository at
`https://rage-ac.github.io/Passwall2/packages`. The workflow adds the build-time
repository key, and the generated firmware also keeps the repository key and
repository entry for later upgrades from LuCI or `apk`.

This feed is for apk-based OpenWrt builds. Use the default OpenWrt 25.12.x
workflow version unless you provide a separate opkg/ipk feed.

## Credits

- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [original Actions-OpenWrt template](https://github.com/P3TERX/Actions-OpenWrt).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
