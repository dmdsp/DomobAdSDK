//
//  DomobSplashCustomEvent.m
//  DMAd
//
//  Created by 刘士林 on 2024/8/16.
//

#import "DomobSplashCustomEvent.h"

@interface DomobSplashCustomEvent ()

@end
@implementation DomobSplashCustomEvent

- (void)splashAdDetailViewDidClose:(nonnull DM_SplashAd *)splashAd {
    [self trackSplashAdDetailClosed];
}

- (void)splashAdDetailViewDidPresentScreen:(nonnull DM_SplashAd *)splashAd {
    [self trackSplashAdDetailWillShow];
}

- (void)splashAdDidClick:(nonnull DM_SplashAd *)splashAd {
    [self trackSplashAdClick];
}

- (void)splashAdDidClose:(nonnull DM_SplashAd *)splashAd {
    [self trackSplashAdClosed:nil];
}

- (void)splashAdDidFailToLoadWithError:(nonnull NSError *)error {
    [self trackSplashAdLoadFailed:error];
}

- (void)splashAdDidFailToRenderWithError:(nonnull NSError *)error {
    
}

- (void)splashAdDidLoad:(nonnull DM_SplashAd *)splashAd {
    [self trackSplashAdLoaded:splashAd];
}

- (void)splashAdDidRender:(nonnull DM_SplashAd *)splashAd {
    [self trackSplashAdRenderSuccess:splashAd adExtra:nil];
}

- (void)splashAdDidShow:(nonnull DM_SplashAd *)splashAd {
    [self trackSplashAdShow];
}

@end
