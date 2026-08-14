#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// SDK 隐私配置，需在 initSDK 前通过 [DMAds shareInstance] setPrivacyConfig: 传入。
/// 所有属性均有默认值，未设置时 SDK 按默认行为采集。
@interface DMPrivacyConfig : NSObject

+ (instancetype)configuration;

/// IDFA
/// customIdfa 有值时直接使用，SDK 不再调用系统 API。
/// canUseIdfa = NO 时 SDK 不采集，customIdfa 也不生效。
@property (nonatomic, copy, nullable) NSString *customIdfa;
@property (nonatomic, assign) BOOL canUseIdfa;    // 默认 YES

/// IDFV
@property (nonatomic, copy, nullable) NSString *customIdfv;
@property (nonatomic, assign) BOOL canUseIdfv;    // 默认 YES

/// 传感器（摇一摇/划一划等交互广告），关闭后交互广告不可用
@property (nonatomic, assign) BOOL canUseMotion;      // 默认 YES

/// 磁盘空间
@property (nonatomic, assign) BOOL canUseSpaceSize;   // 默认 YES

/// 运营商信息
@property (nonatomic, assign) BOOL canUseCarrier;     // 默认 YES

/// 个性化广告推荐开关。
/// 关闭后：不采集设备型号/系统版本/运营商/语言等字段，不上报曝光/点击埋点。
@property (nonatomic, assign) BOOL personalizedAdEnabled; // 默认 YES

@end

NS_ASSUME_NONNULL_END
