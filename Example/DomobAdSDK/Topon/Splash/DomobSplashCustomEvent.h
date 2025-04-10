//
//  DomobSplashCustomEvent.h
//  DMAd
//
//  Created by 刘士林 on 2024/8/16.
//

#import <AnyThinkSplash/AnyThinkSplash.h>
#import <DMAdSDK/DM_SplashAd.h>
#import "DomobBiddingRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface DomobSplashCustomEvent : ATSplashCustomEvent<DMSplashAdDelegate>

@property(nonatomic, strong) DomobBiddingRequest *bidRequest;

@end

NS_ASSUME_NONNULL_END
