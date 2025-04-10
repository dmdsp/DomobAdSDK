//
//  DomobBiddingDelegate.h
//  DMAd
//
//  Created by 刘士林 on 2024/9/6.
//

#import <Foundation/Foundation.h>
#import <DMAdSDK/DM_SplashAd.h>
#import <DMAdSDK/DM_InterstitialAd.h>
#import <DMAdSDK/DM_BannerAd.h>
#import <DMAdSDK/DM_BannerView.h>
#import <DMAdSDK/DM_RewardVideoAd.h>
#import <DMAdSDK/DM_FeedAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomobBiddingDelegate : NSObject <DMSplashAdDelegate,DMInterstitialAdDelegate,DMBannerAdDelegate,DMRewardVideoAdDelegate,DMFeedAdDelegate>
@property(nonatomic, strong)  NSString *unitID;

@end

NS_ASSUME_NONNULL_END
