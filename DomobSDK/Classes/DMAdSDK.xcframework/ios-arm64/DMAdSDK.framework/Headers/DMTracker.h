//
//  DMTracker.h
//  DMAdSDK
//
//  所有广告埋点打点的统一入口，所有事件上报均通过此文件完成。
//
//  上报协议：
//    数据序列化为 JSON（每条事件一行），经 AES-128-ECB / PKCS7 加密后
//    Base64 编码，以 HTTP POST 明文 body 形式上报至打点服务器。
//

#import <Foundation/Foundation.h>

@class DM_ADModel;

NS_ASSUME_NONNULL_BEGIN

// ─────────────────────────────────────────────
// MARK: - 事件 Code（与服务端协议严格对齐）
// ─────────────────────────────────────────────
typedef NS_ENUM(NSInteger, DMTrackEventCode) {

    // ── 初始化 (1xxx) ────────────────────────
    DMTrackEvent_InitBegin              = 1001, // sdk 开始初始化
    DMTrackEvent_InitEnd                = 1002, // sdk 初始化结束（含三方初始化成功）
    DMTrackEvent_UnionInitBegin         = 1003, // 三方 sdk 开始初始化

    // ── 广告请求 (2xxx) ──────────────────────
    DMTrackEvent_HostRequestCall        = 2001, // 宿主调用 sdk 广告请求方法
    DMTrackEvent_HostRequestSuccess     = 2002, // 宿主广告请求回调成功
    DMTrackEvent_HostRequestFail        = 2003, // 宿主广告请求回调失败
    DMTrackEvent_HostRequestTimeout     = 2004, // 宿主广告请求回调超时
    DMTrackEvent_AdnRequestStart        = 2005, // 广告接口发起请求
    DMTrackEvent_AdnRequestSuccess      = 2006, // 广告接口响应成功
    DMTrackEvent_AdnRequestFail         = 2007, // 广告接口响应失败
    DMTrackEvent_AdnRequestLateSuccess  = 2008, // 超时后发起成功
    DMTrackEvent_AdnRequestTimeout      = 2009, // 广告接口发起超时

    // ── 广告展示 (3xxx) ──────────────────────
    DMTrackEvent_HostRenderStart        = 3001, // 宿主开始渲染广告
    DMTrackEvent_HostRenderSuccess      = 3002, // 宿主渲染广告回调成功
    DMTrackEvent_HostRenderFail         = 3003, // 宿主渲染广告回调失败
    DMTrackEvent_MaterialDownloadStart  = 3004, // 开始下载物料（激励视频边下边播）
    DMTrackEvent_MaterialDownloadSuccess= 3005, // 物料下载成功
    DMTrackEvent_MaterialDownloadFail   = 3006, // 物料下载失败
    DMTrackEvent_AdRenderStart          = 3007, // 广告开始渲染
    DMTrackEvent_AdRenderSuccess        = 3008, // 广告渲染成功
    DMTrackEvent_AdRenderFail           = 3009, // 广告渲染失败
    DMTrackEvent_HostShowStart          = 3010, // 宿主广告开始展示
    DMTrackEvent_HostShowSuccess        = 3011, // 宿主广告展示回调成功
    DMTrackEvent_HostShowFail           = 3012, // 宿主广告展示回调失败
    DMTrackEvent_AdShowStart            = 3013, // 广告开始展示
    DMTrackEvent_AdShowSuccess          = 3014, // 广告展示成功
    DMTrackEvent_AdShowFail             = 3015, // 广告展示失败

    // ── 广告点击 (4xxx) ──────────────────────
    DMTrackEvent_Click                  = 4001, // 广告点击
    DMTrackEvent_Skip                   = 4002, // 广告跳过（仅开屏）
    DMTrackEvent_Close                  = 4003, // 广告关闭（插屏/信息流/激励视频）

    // ── 视频广告 (5xxx) ──────────────────────
    DMTrackEvent_VideoStart             = 5001, // 视频开始播放
    DMTrackEvent_VideoQ1                = 5002, // 视频播放 25%
    DMTrackEvent_VideoQ2                = 5003, // 视频播放 50%
    DMTrackEvent_VideoQ3                = 5004, // 视频播放 75%
    DMTrackEvent_VideoComplete          = 5005, // 视频播放完成
    DMTrackEvent_VideoPause             = 5006, // 视频暂停

    // ── 下载广告 (6xxx) ──────────────────────
    DMTrackEvent_DownloadStart          = 6001, // 开始下载
    DMTrackEvent_DownloadResume         = 6002, // 继续下载
    DMTrackEvent_DownloadFail           = 6003, // 下载失败
    DMTrackEvent_DownloadComplete       = 6004, // 下载完成
    DMTrackEvent_InstallStart           = 6005, // 开始安装
    DMTrackEvent_InstallFail            = 6006, // 安装失败
    DMTrackEvent_InstallComplete        = 6007, // 安装完成
    DMTrackEvent_DeeplinkSuccess        = 6008, // 唤起成功
    DMTrackEvent_DeeplinkFail           = 6009, // 唤起失败

    // ── 激励视频特有 (7xxx) ──────────────────
    DMTrackEvent_RewardCountdownEnd     = 7001, // 广告倒计时完成
    DMTrackEvent_RewardIssued           = 7002, // 广告奖励发放完成（需连报 2 次）
    DMTrackEvent_RewardForceExit        = 7003, // 广告点击坚决退出
    DMTrackEvent_RewardExtraClaim       = 7004, // 广告点击获取额外奖励

    // ── 竞价 (8xxx) ──────────────────────────
    DMTrackEvent_BiddingSuccess         = 8001, // 竞价成功
    DMTrackEvent_BiddingFail            = 8002, // 竞价失败
    DMTrackEvent_CacheAdd               = 8003, // 广告放入缓存池
    DMTrackEvent_CacheRemove            = 8004, // 广告移除缓存池
};

// ─────────────────────────────────────────────
// MARK: - 广告形式枚举
// ─────────────────────────────────────────────
typedef NS_ENUM(NSInteger, DMTrackAdType) {
    DMTrackAdType_Splash              = 60002, // 开屏
    DMTrackAdType_Interstitial        = 50001, // 插屏
    DMTrackAdType_Feed                = 20005, // 信息流
    DMTrackAdType_RewardVideo         = 10002, // 激励视频-竖版
    DMTrackAdType_RewardVideoLandscape= 70001, // 激励视频-横版
    DMTrackAdType_Banner              = 40001, // Banner
};

// ─────────────────────────────────────────────
// MARK: - 广告相关参数模型
//
// 公共设备参数由 DMTracker 自动采集，此模型只需填写广告业务参数。
// 不涉及的字段保持默认值（nil / 0）即可，上报时自动忽略零值。
// ─────────────────────────────────────────────
@interface DMTrackAdParams : NSObject

/// APP 媒体 id（SSP 后台申请，若未设置则取 DMTracker.appid）
@property (nonatomic, copy, nullable) NSString *appid;
/// 媒体渠道 id
@property (nonatomic, copy, nullable) NSString *mediaId;
/// 媒体渠道名称
@property (nonatomic, copy, nullable) NSString *mediaName;
/// 广告位 id（多盟 slotID）
@property (nonatomic, copy, nullable) NSString *adsenseid;
/// 策略 id（预留）
@property (nonatomic, copy, nullable) NSString *tid;
/// 广告源 id（多盟=10000 百度=10001 快手=10002 京东=10003 gromore=10004 广点通=10005 tanx=10006 魔秀=10007）
@property (nonatomic, assign) NSInteger adchannelId;
/// 广告源对应的广告位 id
@property (nonatomic, copy, nullable) NSString *slotId;
/// dsp id
@property (nonatomic, copy, nullable) NSString *dsipId;
/// 广告初始化时的 id
@property (nonatomic, copy, nullable) NSString *adInitId;
/// 链路 requestId（整个请求链路的唯一 id，宿主生成）
@property (nonatomic, copy, nullable) NSString *requestId;
/// 广告请求 id（调各广告源时的请求 id）
@property (nonatomic, copy, nullable) NSString *adnrequestId;
/// 是否缓存请求：1=是
@property (nonatomic, assign) NSInteger iscashedreq;
/// 广告形式
@property (nonatomic, assign) DMTrackAdType promotetype;
/// 广告模板样式 id（信息流4种：左文右图=2 右文左图=1 上文下图=3 上图下文=4）
@property (nonatomic, assign) NSInteger impntId;
/// 点击样式
/// 开屏：正常=0 摇一摇=1 滑动=2 扭一扭简版=3 扭一扭=4 擦波流=5
/// 激励视频：正常=1 任务=2 完成+任务=3
@property (nonatomic, assign) NSInteger clickStyle;
/// 物料类型：1=图片 2=视频
@property (nonatomic, assign) NSInteger mType;
/// 是否推送类型广告（仅开屏）：1=是
@property (nonatomic, assign) NSInteger ispush;
/// 图片物料 url 列表
@property (nonatomic, copy, nullable) NSArray<NSString *> *mList;
/// 视频物料 url 列表
@property (nonatomic, copy, nullable) NSArray<NSString *> *vmList;
/// 广告标题
@property (nonatomic, copy, nullable) NSString *title;
/// 广告描述
@property (nonatomic, copy, nullable) NSString *adDescription;
/// 落地页 url
@property (nonatomic, copy, nullable) NSString *url;
/// deeplink url
@property (nonatomic, copy, nullable) NSString *deeplinkUrl;
/// 是否下载类广告：0=否 1=是
@property (nonatomic, assign) NSInteger isDownload;
/// 下载链接
@property (nonatomic, copy, nullable) NSString *downloadUrl;
/// 是否缓存曝光：1=是
@property (nonatomic, assign) NSInteger isCachedImp;
/// 服务端返回价格（分）
@property (nonatomic, assign) NSInteger bidPrice;
/// 实际曝光价格（分，聚合场景中可能与 bidPrice 不同）
@property (nonatomic, assign) NSInteger impPrice;

@end

// ─────────────────────────────────────────────
// MARK: - DMTracker 主类
// ─────────────────────────────────────────────
@interface DMTracker : NSObject

/// 单例
+ (instancetype)sharedInstance;

/// SDK 初始化后调用，设置全局媒体 id（对应埋点字段 appid）
/// 若各次上报需要独立的 appid，也可通过 DMTrackAdParams.appid 覆盖
@property (nonatomic, copy, nullable) NSString *appid;

// ─────────────────────────────────────────────
// MARK: - 参数构建工厂方法
// ─────────────────────────────────────────────

/**
 * 构建广告埋点参数，从 DM_ADModel 中自动填充物料信息。
 * 广告类只需提供 slotID / promotetype / bidPrice / model 即可，
 * 无需自行组装 DMTrackAdParams。
 */
+ (DMTrackAdParams *)buildParamsWithSlotID:(nullable NSString *)slotID
                               promotetype:(DMTrackAdType)promotetype
                                  bidPrice:(NSInteger)bidPrice
                                     model:(nullable DM_ADModel *)model;

/**
 * 将 DM_ADModel 中的物料字段填充到已有的 params 中。
 * 在广告响应回来后调用，补充 dsipId / mType / mList / vmList / title 等。
 */
+ (void)fillModelParams:(DMTrackAdParams *)params fromModel:(nullable DM_ADModel *)model;

/// 生成请求 ID（ap）：时间戳(ms)_随机8位_caid(dmid)
+ (NSString *)generateRequestId;
/// 生成 ADN 请求 ID（aq）：时间戳(ms)_随机10位_caid(dmid)
+ (NSString *)generateAdnRequestId;

// ─────────────────────────────────────────────
// MARK: - 基础上报方法
// ─────────────────────────────────────────────

/// 上报埋点事件（含广告参数）
- (void)trackEvent:(DMTrackEventCode)code
          adParams:(nullable DMTrackAdParams *)adParams;

/// 上报埋点事件（无广告参数，用于初始化等纯设备事件）
- (void)trackEvent:(DMTrackEventCode)code;

// ─────────────────────────────────────────────
// MARK: - 分组便捷方法（内部自动联报多个 code）
// ─────────────────────────────────────────────

/// 宿主调用广告请求（2001）
- (void)trackRequestCallWithParams:(DMTrackAdParams *)params;
/// 广告接口发起请求（2005）
- (void)trackAdnRequestStartWithParams:(DMTrackAdParams *)params;
/// 请求成功（2002 + 2006）
- (void)trackRequestSuccessWithParams:(DMTrackAdParams *)params;
/// 请求失败（2003 + 2007）
- (void)trackRequestFailWithParams:(DMTrackAdParams *)params;

/// 开始渲染（3001 + 3007）
- (void)trackRenderStartWithParams:(DMTrackAdParams *)params;
/// 渲染成功（3002 + 3008）
- (void)trackRenderSuccessWithParams:(DMTrackAdParams *)params;
/// 渲染失败（3003 + 3009）
- (void)trackRenderFailWithParams:(DMTrackAdParams *)params;

/// 广告展示（3010 + 3011 + 3013 + 3014）
- (void)trackShowWithParams:(DMTrackAdParams *)params;

/// 广告点击（4001）
- (void)trackClickWithParams:(DMTrackAdParams *)params;
/// 广告跳过，开屏专用（4002）
- (void)trackSkipWithParams:(DMTrackAdParams *)params;
/// 广告关闭（4003）
- (void)trackCloseWithParams:(DMTrackAdParams *)params;

/// 竞价成功（8001）
- (void)trackBiddingSuccessWithParams:(DMTrackAdParams *)params;
/// 竞价失败（8002）
- (void)trackBiddingFailWithParams:(DMTrackAdParams *)params;
/// 广告放入缓存池（8003）
- (void)trackCacheAddWithParams:(DMTrackAdParams *)params;

/// 激励完成：倒计时结束（7001）+ 奖励发放连报2次（7002×2）
- (void)trackRewardCompleteWithParams:(DMTrackAdParams *)params;

/// 视频开始播放（5001）
- (void)trackVideoStartWithParams:(DMTrackAdParams *)params;
/// 视频播放 25%（5002）
- (void)trackVideoQ1WithParams:(DMTrackAdParams *)params;
/// 视频播放 50%（5003）
- (void)trackVideoQ2WithParams:(DMTrackAdParams *)params;
/// 视频播放 75%（5004）
- (void)trackVideoQ3WithParams:(DMTrackAdParams *)params;
/// 视频播放完成（5005）
- (void)trackVideoCompleteWithParams:(DMTrackAdParams *)params;
/// 视频暂停（5006）
- (void)trackVideoPauseWithParams:(DMTrackAdParams *)params;

@end

NS_ASSUME_NONNULL_END
