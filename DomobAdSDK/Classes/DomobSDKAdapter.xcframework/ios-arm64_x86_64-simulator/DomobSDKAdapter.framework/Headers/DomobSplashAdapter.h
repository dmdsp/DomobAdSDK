//
//  DomobSplashAdapter.h
//  DMengAdSDK
//
//  Created by 刘士林 on 2024/5/10.
//

#import <Foundation/Foundation.h>
#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DM_Macro.h>
#import <DMAdSDK/DMUnionModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DomobSplashManagerDelegate;
@interface DomobSplashAdapter : NSObject
typedef void(^DomobSplashAdapterCompletion)(DomobSplashAdapter * splashAdapter);
//广告位id
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;
//当前广告的报价
@property(nonatomic, assign, readonly) long ecpm;

@property(nonatomic, assign, readonly) long originalPrice;
@property (nonatomic , copy) NSString * materialId ;
@property(nonatomic, assign) int64_t bidTs;
@property (nonatomic, strong) DMUnionTrackerModel * trackerModel;
@property (nonatomic, weak) id<DomobSplashManagerDelegate> delegate;

/// 初始化开屏广告
/// - Parameter completion: 加载完成后返回的对象
/// - Parameter slotID: 广告位id
/// - Parameter adSize: 尺寸,必须>=屏幕高度的75%，如果高度<75%，将会以屏幕实际高度渲染，可能会导致图片变形或影响广告渲染速度
- (void)loadSplashAdTemplateAdWithSlotID:(nonnull NSString *)slotID adSize:(CGSize)adSize completion:(DomobSplashAdapterCompletion)completion;
//竞价成功的上报
- (void)biddingSplashSuccess:(long)price;
//竞价失败的上报
- (void)biddingSplashFailed:(long)price Code:(DMAdBiddingCode)code;
/// 展示广告
/// - Parameter viewController: 当前要展示的控制器
-(void)showSplashViewInRootViewController:(UIViewController *)viewController;
-(NSString*)getUnionSdkTracker;
@end

@protocol DomobSplashManagerDelegate <NSObject>
/// 加载成功
- (void)splashAdDidLoad :(DomobSplashAdapter*)splashAd;
/// 加载失败
- (void)splashAdDidFailToLoadWithError:(NSError *)error;
/// 渲染成功
- (void)splashAdDidRender:(DomobSplashAdapter*)splashAd;;
/// 渲染失败
- (void)splashAdDidFailToRenderWithError:(NSError *)error;
/// 广告已经打开
- (void)splashAdDidShow:(DomobSplashAdapter *)splashAd;
/// 广告被点击
- (void)splashAdDidClick:(DomobSplashAdapter *)splashAd;
/// 广告被关闭
- (void)splashAdDidClose:(DomobSplashAdapter *)splashAd;

@end

NS_ASSUME_NONNULL_END
