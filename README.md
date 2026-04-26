# Actions-OpenWrt

A customized OpenWrt firmware for x86_64 routers, built with GitHub Actions.

## Usage

This repository provides a customized OpenWrt firmware build for x86_64 routers with pre-configured packages and drivers.

- Fork this repository.
- Modify `.config` as needed for your hardware.
- Push changes to trigger GitHub Actions build.
- Download the built firmware from the Actions artifacts.

## Workflows

- `OpenWrt Builder`: full build and release flow.
- `OpenWrt Fast Builder`: compile-focused flow with `ccache` to speed up repeated builds.

For `OpenWrt Fast Builder`, use `workflow_dispatch` inputs to choose:

- `repo_branch`
- `config_file`
- `enable_ccache`
- `upload_artifacts`

## Supported Hardware

This firmware includes drivers for the following network interfaces:

- **Intel IGC**: 2.5G/10G Ethernet controllers
- **Realtek RTL8169**: 1G Ethernet controllers (e.g., RTL8111H)
- **Realtek RTL8188EE**: Wireless 802.11b/g/n adapters

## Built-in Applications

| Application         | Description                                                |
| ------------------- | ---------------------------------------------------------- |
| LuCI Web Interface  | Web-based management interface (with Chinese localization) |
| Package Manager     | LuCI app for managing software packages                    |
| Terminal (ttyd)     | Web-based terminal access                                  |
| UPnP                | Universal Plug and Play support                            |
| Wake on LAN         | Remote wake-up functionality                               |
| Sing-Box            | Proxy and VPN client/server                                |
| IRQ Balance         | CPU interrupt load balancing                               |
| Wireless Management | Basic WPA supplicant/hostapd support                       |
| Network Utilities   | curl, wget-ssl, etherwake                                  |
| Kernel Modules      | TUN/TAP, NF TPROXY, NFT TPROXY for advanced networking     |

## Credits

- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [original Actions-OpenWrt template](https://github.com/P3TERX/Actions-OpenWrt).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
