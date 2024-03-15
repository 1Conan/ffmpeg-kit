// swift-tools-version:5.10

import PackageDescription
import CompilerPluginSupport

let release = "1.0.16"
let frameworks = [
  "ffmpegkit": "eb13b6e43fa20b2138caeb5d692c1045ab2794d1788239cef2dc91c697abecaa",
  "libavcodec": "558ca6a5f34825f3f9c1a0bf07acb4e8b693831ac6ef09d02997db3809e777af",
  "libavdevice": "2698d91f74486de75fcac6bae7432f3a850ff24f446ab919ea972a0915dd38e2",
  "libavfilter": "c7a029818e761adfa7b3c33b132a22296b342a0339593a3431a0cb71d62c9b84",
  "libavformat": "fe3450627de7441ef1402b31ab0e29b142e8bf9f609b72a20dbd5a4c54aa572c",
  "libavutil": "58e34372a0a2caf901f6fb0775bc39caded0c3441b72f26a5da8aecc49aec6ba",
  "libswresample": "7340eee1adfc7556b11fcd1e44384471bcdacf139e5aaf8181288031f9829cdb",
  "libswscale": "bbafce0fbbc04c7bf2604995ee7642d268609db04c732e2da03f73bc564cfa6f",
]

let package = Package(
    name: "FFmpeg",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "FFmpeg",
            type: .dynamic,
            targets: ["FFmpeg"]
        ),
    ],
    targets: [
      .target(
        name: "CFFmpegKit",
        dependencies: frameworks.map { .target(name: $0.key) }
      ),
      .target(
        name: "FFmpeg",
        dependencies: ["CFFmpegKit"]
      ),
    ] + frameworks.map { framework, hash in
        .binaryTarget(
            name: framework,
            url: "https://github.com/1Conan/ffmpeg-kit/releases/download/\(release)/\(framework).xcframework.zip",
            checksum: hash
        )
    }
)

print(package)
