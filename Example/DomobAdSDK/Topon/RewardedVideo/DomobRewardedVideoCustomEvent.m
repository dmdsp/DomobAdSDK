//
//  DomobRewardedVideoCustomEvent.m
//  DMAd
//
//  Created by 刘士林 on 2024/8/27.
//

#import "DomobRewardedVideoCustomEvent.h"

@implementation DomobRewardedVideoCustomEvent

- (void)rewardVideoAdDetailViewDidClose:(nonnull DM_RewardVideoAd *)rewardVideoAd { 
    
}

- (void)rewardVideoAdDetailViewDidPresentScreen:(nonnull DM_RewardVideoAd *)rewardVideoAd { 
    
}

- (void)rewardVideoAdDidClick:(nonnull DM_RewardVideoAd *)rewardVideoAd { 
    [self trackRewardedVideoAdClick];
}

- (void)rewardVideoAdDidClose:(nonnull DM_RewardVideoAd *)rewardVideoAd { 
    [self trackRewardedVideoAdCloseRewarded:NO extra:nil];
}

- (void)rewardVideoAdDidComplete:(nonnull DM_RewardVideoAd *)rewardVideoAd {
    [self trackRewardedVideoAdCloseRewarded:YES extra:nil];
}

- (void)rewardVideoAdDidFailToLoadWithError:(nonnull NSError *)error { 
    [self trackRewardedVideoAdLoadFailed:error];
}

- (void)rewardVideoAdDidFailToRenderWithError:(nonnull NSError *)error { 
    
}

- (void)rewardVideoAdDidFailToShowWithError:(nonnull NSError *)error { 
    [self trackRewardedVideoAdPlayEventWithError:error];
}

- (void)rewardVideoAdDidLoad:(nonnull DM_RewardVideoAd *)rewardVideoAd { 
    [self trackRewardedVideoAdLoaded:rewardVideoAd adExtra:nil];
}

- (void)rewardVideoAdDidRender:(nonnull DM_RewardVideoAd *)rewardVideoAd { 
    [self trackRewardedVideoAdRenderSuccess:rewardVideoAd adExtra:nil];
}

- (void)rewardVideoAdDidShow:(nonnull DM_RewardVideoAd *)rewardVideoAd { 
    [self trackRewardedVideoAdShow];
}

- (void)rewardVideoAdPlayToEndTime:(nonnull DM_RewardVideoAd *)rewardVideoAd { 
    [self trackRewardedVideoAdVideoEnd];
}

@end
