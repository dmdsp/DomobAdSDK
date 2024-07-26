//
//  DM_BannerAd.h
//  DMAdSDK
//
//  Created by 刘士林 on 2024/3/27.
//

#import <Foundation/Foundation.h>

@protocol DMBannerAdDelegate;
@class DM_BannerView;
NS_ASSUME_NONNULL_BEGIN

@interface DM_BannerAd : NSObject
//广告位id
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;
//当前广告的报价
@property(nonatomic, assign, readonly) long bidPrice;
//竞价成功地址
@property (nonatomic , copy ,readonly)NSArray  * winNoticeUrl ;
//竞价失败地址
@property (nonatomic , copy, readonly) NSArray * lnurl;
//banner视图
@property (nonatomic,strong) DM_BannerView *bannerView;
//使用controller present 落地页
@property (nonatomic, strong) UIViewController *presentAdViewController;

@property (nonatomic , copy) NSString * materialId ;


/// 初始化banner广告和配置代理
/// - Parameter delegate: 代理
/// - Parameter slotID: 广告位id
/// - Parameter isHidden:设置点击关闭时弹出视图是否隐藏，是为隐藏
- (instancetype)loadBannerAdTemplateAdWithSlotID:(NSString *)slotID popupViewHidden:(BOOL)isHidden delegate:(id<DMBannerAdDelegate>)delegate ;
//竞价成功的上报
- (void)biddingBannerSuccess:(long)price;
//竞价失败的上报
- (void)biddingBannerFailed:(long)price Code:(DMAdBiddingCode)code;

@end

@protocol DMBannerAdDelegate <NSObject>
/// 加载成功
- (void)bannerAdDidLoad :(DM_BannerAd*)bannerAd;
/// 加载失败
- (void)bannerAdDidFailToLoadWithError:(NSError *)error;
/// 渲染成功
- (void)bannerAdDidRender:(DM_BannerAd*)bannerAd;;
/// 渲染失败
- (void)bannerAdDidFailToRenderWithError:(NSError *)error;
/// 广告已经打开
- (void)bannerAdDidShow:(DM_BannerAd *)bannerAd;
/// 广告被点击
- (void)bannerAdDidClick:(DM_BannerAd *)bannerAd;
/// 广告被关闭
- (void)bannerAdDidClose:(DM_BannerAd *)bannerAd;

@end

NS_ASSUME_NONNULL_END
