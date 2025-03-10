# Ruby Distroless
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build Status](https://github.com/junminhong/ruby-distroless/actions/workflows/build.yml/badge.svg)](https://github.com/junminhong/ruby-distroless/actions)

Ruby Distroless 是一個開源專案，旨在利用 Google 的 [distroless](https://github.com/GoogleContainerTools/distroless) 映像構建出精簡且安全的 Ruby 運行環境映像。

透過本專案，你可以輕鬆構建支援多平台（如 amd64 與 arm64）及多個 Ruby 版本的最小化映像，適用於生產環境部署，降低安全風險並縮小映像體積。

## 目前支援的 Ruby 版本
範圍為 Ruby 2.5 至 Ruby 3.4，具體包括：
- Ruby 2.5.9
- Ruby 2.6.10
- Ruby 2.7.8
- Ruby 3.0.7
- Ruby 3.1.6
- Ruby 3.2.7
- Ruby 3.3.7
- Ruby 3.4.2

## 特色
- **精簡安全**：基於 distroless 映像，僅包含運行 Ruby 所需的依賴庫，避免多餘工具帶來的潛在風險。
- **多平台支援**：利用 Docker Buildx 同時構建 amd64 與 arm64 映像。
- **多版本構建**：支援 Ruby 2.5 至 Ruby 3.4 多個版本，方便用戶根據需求選擇合適版本。
- **自動化構建**：內建 GitHub Actions 工作流程，自動構建並推送映像至 GitHub Container Registry (GHCR)。

## 安裝
你可以從 [GitHub Container Registry (GHCR)](https://ghcr.io) 拉取構建好的映像。例如，要拉取 Ruby 3.3.7 版本的 amd64 映像：

```bash
# amd64
docker pull ghcr.io/junminhong/ruby-distroless:3.3.7-amd64
# arm65
docker pull ghcr.io/junminhong/ruby-distroless:3.3.7-arm64
```

## 使用方式
你可以直接使用該映像來運行 Ruby 程式。例如：

```bash
# amd64
docker run --rm ghcr.io/junminhong/ruby-distroless:3.3.7-amd64 ruby -v
# arm65
docker run --rm ghcr.io/junminhong/ruby-distroless:3.3.7-arm64 ruby -v
```

這將顯示 Ruby 版本資訊。如果你需要在容器中運行其他 Ruby 程式，請參考 Docker 的 [CMD 指令](https://docs.docker.com/engine/reference/builder/#cmd) 進行調整。

## 構建映像
你可以使用我們提供的 `Dockerfile` 與 `build.sh` 腳本自行構建映像。

### Dockerfile
本專案的 Dockerfile 利用多階段構建將官方 Ruby slim 映像中的 Ruby 執行檔與依賴庫複製到精簡的 distroless 映像中。請參考 [Dockerfile](./Dockerfile) 範例。

### build.sh
本專案附帶一份 `build.sh` 腳本，可依序構建多個 Ruby 版本的映像。

1. 賦予執行權限：
   ```bash
   chmod +x build.sh
   ```
2. 若要構建 ARM 映像，先設定平台環境變數：
   ```bash
   export PLATFORM=linux/arm64
   ```
3. 若要推送映像到遠端，設定：
   ```bash
   export PUSH_IMAGE=true
   ```
4. 執行腳本：
   ```bash
   ./build.sh
   ```

## GitHub Actions
本專案使用 GitHub Actions 自動構建多平台、多 Ruby 版本的映像，並推送到 GitHub Container Registry (GHCR)。

請參考 [`.github/workflows/build.yml`](./.github/workflows/build.yml) 了解具體工作流程設定。每當你 push 到 main 分支或發起 PR 時，都會觸發自動構建與發佈。

## 貢獻
我們歡迎任何形式的貢獻！如果你有好的想法、Bug 回報或功能改進，請透過 Pull Request 或 Issue 與我們聯繫。

### 貢獻指南
1. Fork 本專案。
2. 建立新的分支，並在上面進行修改。
3. 提交 Pull Request，並詳細描述你的修改內容。
4. 我們會儘快審查並回覆你的 PR。

## 授權
本專案採用 [MIT 授權](LICENSE.md)。詳細授權條款請參考 [LICENSE](LICENSE.md) 文件。

## 聯絡我們
- GitHub: [junminhong](https://github.com/junminhong)
- 如有任何疑問或建議，歡迎提出 Issue 或通過 Pull Request 與我交流。
