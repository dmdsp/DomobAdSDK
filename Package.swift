// swift-tools-version:5.7
import PackageDescription

// 多盟广告 SDK —— Swift Package Manager 分发（与 CocoaPods 渠道并行，二进制共用）。
//
// 说明：
// - 包名 "DMAdSDK" + target 名 "Bundle"，SPM 生成的资源包即 DMAdSDK_Bundle.bundle，
//   与 SDK 内 DM_Macro.currectBundle 里写死的名字一致，无需改 SDK 代码。
// - 资源用 .process，使文件落在 bundle 根目录（.copy("Resources") 会多一层子目录，pathForResource 找不到）。
// - SDK 已移除全部 Objective-C category，接入方无需设置 -ObjC。
// - binaryTarget 与 CocoaPods 共用 DomobSDK/Classes/DMAdSDK.xcframework，发版时只需更新这一份。
// - 资源在 Sources/Bundle/Resources，需与 DomobSDK/Classes/DMAdSDK_Bundle.bundle 保持一致（发版时同步）。
// - 仅包含 DMAdSDK 本体；各 Adapter 暂仍走 CocoaPods。
let package = Package(
    name: "DMAdSDK",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "DMAdSDK", targets: ["DMAdSDKBinary", "Bundle"])
    ],
    targets: [
        .binaryTarget(name: "DMAdSDKBinary", path: "DomobSDK/Classes/DMAdSDK.xcframework"),
        .target(
            name: "Bundle",
            path: "Sources/Bundle",
            resources: [.process("Resources")],
            linkerSettings: [
                .linkedFramework("AdSupport"),
                .linkedFramework("AppTrackingTransparency"),
                .linkedFramework("CoreLocation"),
                .linkedFramework("CoreMotion"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("WebKit"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("SystemConfiguration"),
            ]
        ),
    ]
)
