//
//  DMAds.h
//  DMAdSDK
//
//  Created by 刘士林 on 2024/3/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DMAdBiddingCode) {
    DMAdBiddingCodeUnknown = 1001, // 未知
    DMAdBiddingCodeNoValidAd = 1002, // 无有效广告
    DMAdBiddingCodeNoValidParam = 1003, // 无有效参数（缺少必填字段）
    DMAdBiddingCodeNoValidSpec = 1004, // 无有效规格
    DMAdBiddingCodeTimeout = 1005, // 超时
    DMAdBiddingCodeExceptionResponse = 1006, // 异常响应
    DMAdBiddingCodeFloorPriceOvershoot = 2001, // 底价过高
    DMAdBiddingCodeLowMassFlow = 2002, // 低质量流量
    DMAdBiddingCodeHitCounterCheat = 2003, // 命中反作弊
    DMAdBiddingCodeBuyThroughOtherChannel = 2004 // 已通过其他渠道采买
};
typedef NS_ENUM(NSInteger, AdTemplateId) {
    AdTemplateIdSplash = 60002, // 开屏
    AdTemplateIdFeed = 20005, // 信息流
    AdTemplateIdBanner = 40001, // Banner
    AdTemplateIdInterstitial = 50001, // 插屏
    AdTemplateIdRewardVideoLand = 70001, // 激励视频-横屏
    AdTemplateIdRewardVideoPort = 10002 // 激励视频-竖屏
};
typedef void(^CompletionEvent)(BOOL success);
@class DMUnionModel;
@class DMUnionTrackerModel;

@interface DMAds : NSObject
@property(nonatomic,strong) DMUnionModel *ksModel, *gmModel,*configModel;

// 单例
+(instancetype)shareInstance;

//SDK 初始化
-(void)initSDK;
//聚合初始化
-(void)initUnionSDKCompletion:(CompletionEvent) completion;
//获取SDK版本号
-(NSString*)getSdkVersion;
//设备信息
-(NSString*)getSdkDevice;
//
-(NSString*)getUnionSdkTracker:(DMUnionTrackerModel *)unionTrackerModel templateId:(AdTemplateId)templateId;

@end

NS_ASSUME_NONNULL_END
