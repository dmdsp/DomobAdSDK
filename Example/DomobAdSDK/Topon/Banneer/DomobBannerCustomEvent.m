//
//  DomobBannerCustomEvent.m
//  DMAd
//
//  Created by 刘士林 on 2024/8/27.
//

#import "DomobBannerCustomEvent.h"

@implementation DomobBannerCustomEvent
/// 加载成功
- (void)bannerAdDidLoad :(DM_BannerAd*)bannerAd{
    [self trackBannerAdLoaded:bannerAd adExtra:nil];
}
/// 加载失败
- (void)bannerAdDidFailToLoadWithError:(NSError *)error{
    [self trackBannerAdLoadFailed:error];
}
/// 渲染成功
- (void)bannerAdDidRender:(DM_BannerAd*)bannerAd{
    [self trackBannerAdRenderSuccess:bannerAd adExtra:nil];
}
/// 渲染失败
- (void)bannerAdDidFailToRenderWithError:(NSError *)error{
    
}
/// 广告已经打开
- (void)bannerAdDidShow:(DM_BannerAd *)bannerAd{
    [self trackBannerAdImpression];
}
/// 广告被点击
- (void)bannerAdDidClick:(DM_BannerAd *)bannerAd{
    [self trackBannerAdClick];
}
/// 广告被关闭
- (void)bannerAdDidClose:(DM_BannerAd *)bannerAd{
    [self trackBannerAdClosed];
}
/// 广告详情页关闭回调
- (void)bannerAdDetailViewDidClose:(DM_BannerAd *)bannerAd{
    [self trackBannerAdDetailClosed];
}
/// 广告详情页将展示回调
- (void)bannerAdDetailViewDidPresentScreen:(DM_BannerAd *)bannerAd{
    
}
@end
