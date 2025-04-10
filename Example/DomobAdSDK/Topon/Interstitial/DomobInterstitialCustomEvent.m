//
//  DomobInterstitialCustomEvent.m
//  DMAd
//
//  Created by 刘士林 on 2024/8/27.
//

#import "DomobInterstitialCustomEvent.h"

@implementation DomobInterstitialCustomEvent

- (void)interstitialAdDetailViewDidClose:(nonnull DM_InterstitialAd *)interstitialAd { 
    
}

- (void)interstitialAdDetailViewDidPresentScreen:(nonnull DM_InterstitialAd *)interstitialAd { 
    
}

- (void)interstitialAdDidClick:(nonnull DM_InterstitialAd *)interstitialAd { 
    [self trackInterstitialAdClick];
}

- (void)interstitialAdDidClose:(nonnull DM_InterstitialAd *)interstitialAd { 
    [self trackInterstitialAdClose:nil];
}

- (void)interstitialAdDidFailToLoadWithError:(nonnull NSError *)error { 
    [self trackInterstitialAdLoadFailed:error];
}

- (void)interstitialAdDidFailToRenderWithError:(nonnull NSError *)error { 
    
}

- (void)interstitialAdDidLoad:(nonnull DM_InterstitialAd *)interstitialAd { 
    [self trackInterstitialAdLoaded:interstitialAd adExtra:nil];
}

- (void)interstitialAdDidRender:(nonnull DM_InterstitialAd *)interstitialAd { 
    [self trackInterstitialAdRenderSuccess:interstitialAd adExtra:nil];
}

- (void)interstitialAdDidShow:(nonnull DM_InterstitialAd *)interstitialAd { 
    [self trackInterstitialAdShow];
}

@end
