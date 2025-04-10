//
//  DomobNativeCustomEvent.m
//  DMAd
//
//  Created by 刘士林 on 2024/8/27.
//

#import "DomobNativeCustomEvent.h"
#import <DMAdSDK/DM_FeedView.h>
#import <DMAdSDK/DM_ADModel.h>

@interface DomobNativeCustomEvent ()

@end

@implementation DomobNativeCustomEvent
- (void)feedAdDidClick:(DM_FeedAd *)feedAd {
    [self trackNativeAdClick];
}

- (void)feedAdDidClose:(DM_FeedAd *)feedAd {
    [self trackNativeAdClosed];
}

- (void)feedAdDidFailToLoadWithError:(NSError *)error {
    [self trackNativeAdLoadFailed:error];
}

- (void)feedAdDidFailToRenderWithError:(NSError *)error {
    
}

- (void)feedAdDidLoad:(DM_FeedAd *)feedAd {
   
}

- (void)feedAdDidRender:(DM_FeedAd *)feedAd {
    
}

- (void)feedAdDidShow:(DM_FeedAd *)feedAd {
    [self trackNativeAdShow:YES];
}

- (void)feedAdDetailViewDidClose:(DM_FeedAd *)feedAd {
    
}

- (void)feedAdDetailViewDidPresentScreen:(nonnull DM_FeedAd *)feedAd {
    
}

- (void)feedRendering:(DM_FeedAd *)feedAd isDmTemplateAd:(BOOL)isdmtemplatead{
    NSMutableDictionary *asset = [NSMutableDictionary dictionary];
    [asset setValue:self forKey:kATAdAssetsCustomEventKey];
    [asset setValue:self forKey:kATAdAssetsDelegateObjKey];
    [asset setValue:self forKey:kATAdAssetsNativeCustomEventKey];
    [asset setValue:feedAd forKey:kATAdAssetsCustomObjectKey];
    // 原生模板广告
    if(isdmtemplatead){
        [asset setValue:@(YES) forKey:kATNativeADAssetsIsExpressAdKey];
    }else{
        [asset setValue:@(NO) forKey:kATNativeADAssetsIsExpressAdKey];
    }
    [asset setValue:@(feedAd.feedView.bounds.size.width) forKey:kATNativeADAssetsNativeExpressAdViewWidthKey];
    [asset setValue:@(feedAd.feedView.bounds.size.height) forKey:kATNativeADAssetsNativeExpressAdViewHeightKey];

    [asset setValue:feedAd.feedModel.title forKey:kATNativeADAssetsMainTitleKey];
    [asset setValue:feedAd.feedModel.appImage forKey:kATNativeADAssetsIconURLKey];
    [asset setValue:feedAd.feedModel.picture_url forKey:kATNativeADAssetsImageURLKey];
    [asset setValue:@(NO) forKey:kATNativeADAssetsContainsVideoFlag];

    NSMutableArray<NSDictionary*>* assets = [NSMutableArray<NSDictionary*> array];
    [assets addObject:asset];
    [self trackNativeAdLoaded:assets];
}

@end
