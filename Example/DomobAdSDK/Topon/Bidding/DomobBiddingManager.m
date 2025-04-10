//
//  DomobBiddingManager.m
//  DMAd
//
//  Created by 刘士林 on 2024/8/29.
//

#import "DomobBiddingManager.h"
#import <DMAdSDK/DM_SplashAd.h>
#import <DMAdSDK/DM_InterstitialAd.h>
#import "DomobBiddingDelegate.h"
#import "DomobSplashCustomEvent.h"
#import <DMAdSDK/DM_RewarVideoModel.h>
#import <DMAdSDK/DM_RewardVideoAd.h>
#import <AnyThinkRewardedVideo/AnyThinkRewardedVideo.h>
#import <DMAdSDK/DM_FeedAd.h>

@interface DomobBiddingManager ()

@property (nonatomic, strong) NSMutableDictionary *bidingAdStorageAccessor;
@property (nonatomic, strong) NSMutableDictionary *bidingAdDelegate;

@end


@implementation DomobBiddingManager

+ (instancetype)sharedInstance {
    static DomobBiddingManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DomobBiddingManager alloc] init];
        sharedInstance.bidingAdStorageAccessor = [NSMutableDictionary dictionary];
        sharedInstance.bidingAdDelegate = [NSMutableDictionary dictionary];
    });
    return sharedInstance;
}

- (DomobBiddingRequest *)getRequestItemWithUnitID:(NSString *)unitID {
    @synchronized (self) {
        return [self.bidingAdStorageAccessor objectForKey:unitID];
    }
    
}

- (void)removeRequestItmeWithUnitID:(NSString *)unitID {
    @synchronized (self) {
        [self.bidingAdStorageAccessor removeObjectForKey:unitID];
    }
}

- (void)savaBiddingDelegate:(DomobBiddingDelegate *)delegate withUnitID:(NSString *)unitID {
    @synchronized (self) {
        [self.bidingAdDelegate setObject:delegate forKey:unitID];
    }
}

- (void)removeBiddingDelegateWithUnitID:(NSString *)unitID {
    @synchronized (self) {
        if (unitID.length) {
            [self.bidingAdDelegate removeObjectForKey:unitID];
        }
    }
}

// 保存相应的竞价request，并向不同广告类型完成绑定
- (void)startWithRequestItem:(DomobBiddingRequest *)request {
    
    [self.bidingAdStorageAccessor setObject:request forKey:request.unitID];
    switch (request.adType) {
        case ESCAdFormatSplash: {
            // 获取代理
            DomobBiddingDelegate *delegate = [[DomobBiddingDelegate alloc] init];
            delegate.unitID = request.unitID;
            [request.customObject setValue:delegate forKey:@"delegate"];
            [self savaBiddingDelegate:delegate withUnitID:request.unitID];
             
            DM_SplashAd *splash = [[DM_SplashAd alloc] loadSplashAdTemplateAdWithSlotID:request.unitID adSize:CGSizeMake(300, 300) delegate:delegate];
            request.customObject = splash;
 
            break;
        }
        case ESCAdFormatInterstitial: {
            // 获取代理
            DomobBiddingDelegate *delegate = [[DomobBiddingDelegate alloc] init];
            delegate.unitID = request.unitID;
            [request.customObject setValue:delegate forKey:@"delegate"];
            [self savaBiddingDelegate:delegate withUnitID:request.unitID];
             
            DM_InterstitialAd * interstitialAd = [[DM_InterstitialAd alloc] loadInterstitialAdTemplateAdWithSlotID:request.unitID delegate:delegate];
            request.customObject = interstitialAd;
 
            break;
        }
        case ESCAdFormatBanner: {
            // 获取代理
            DomobBiddingDelegate *delegate = [[DomobBiddingDelegate alloc] init];
            delegate.unitID = request.unitID;
            [request.customObject setValue:delegate forKey:@"delegate"];
            [self savaBiddingDelegate:delegate withUnitID:request.unitID];
             
            DM_BannerAd * bannerAd = [[DM_BannerAd alloc] loadBannerAdTemplateAdWithSlotID:request.unitID popupViewHidden:NO delegate:delegate];
            request.customObject = bannerAd;
 
            break;
        }
        case ESCAdFormatRewardedVideo: {
            // 获取代理
            DomobBiddingDelegate *delegate = [[DomobBiddingDelegate alloc] init];
            delegate.unitID = request.unitID;
            [request.customObject setValue:delegate forKey:@"delegate"];
            [self savaBiddingDelegate:delegate withUnitID:request.unitID];
             
            DM_RewarVideoModel *model = [[DM_RewarVideoModel alloc] init];
            if (request.extraInfo[kATAdLoadingExtraUserIDKey] != nil) {
                model.userId = request.extraInfo[kATAdLoadingExtraUserIDKey];
            }
            if (request.extraInfo[kATAdLoadingExtraMediaExtraKey] != nil) {
                model.extra = request.extraInfo[kATAdLoadingExtraMediaExtraKey];
            }
            
            DM_RewardVideoAd * rewardVideoAd = [[DM_RewardVideoAd alloc] loadRewardVideoAdTemplateAdWithSlotID:request.unitID withRewarVideoModel:model delegate:delegate];
            request.customObject = rewardVideoAd;
 
            break;
        }
        case ESCAdFormatFeed: {
            // 获取代理
            DomobBiddingDelegate *delegate = [[DomobBiddingDelegate alloc] init];
            delegate.unitID = request.unitID;
            [request.customObject setValue:delegate forKey:@"delegate"];
            [self savaBiddingDelegate:delegate withUnitID:request.unitID];
    
            DM_FeedAd * feedAd = [[DM_FeedAd alloc] loadFeedAdTemplateAdWithSlotID:request.unitID popupViewHidden:NO delegate:delegate];
            request.customObject = feedAd;
 
            break;
        }
        default:
            break;
    }
}

@end
