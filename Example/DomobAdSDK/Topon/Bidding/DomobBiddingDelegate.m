//
//  DomobBiddingDelegate.m
//  DMAd
//
//  Created by 刘士林 on 2024/9/6.
//

#import "DomobBiddingDelegate.h"
#import "DomobBiddingRequest.h"
#import "DomobBiddingManager.h"
#import <AnyThinkSplash/AnyThinkSplash.h>
#import <AnyThinkNative/AnyThinkNative.h>

@interface DomobBiddingDelegate ()
@end
@implementation DomobBiddingDelegate

#pragma - splash
- (void)splashAdDidLoad:(nonnull DM_SplashAd *)splashAd {
    DomobBiddingRequest *request = [[DomobBiddingManager sharedInstance] getRequestItemWithUnitID:self.unitID];
    NSLog(@"request.unitGroup.bidTokenTime = %f",request.unitGroup.bidTokenTime);
    ATBidInfo *bidInfo = [ATBidInfo bidInfoC2SWithPlacementID:request.placementID unitGroupUnitID:request.unitGroup.unitID adapterClassString:request.unitGroup.adapterClassString price:[NSString stringWithFormat:@"%ld",splashAd.bidPrice] currencyType:ATBiddingCurrencyTypeCNYCents expirationInterval:request.unitGroup.bidTokenTime customObject:splashAd];
    bidInfo.networkFirmID = request.unitGroup.networkFirmID;
    if(request.bidCompletion){
        request.bidCompletion(bidInfo, nil);
    }
}
- (void)splashAdDidFailToLoadWithError:(NSError *)error{
    
}

#pragma - interstitial
- (void)interstitialAdDidLoad:(nonnull DM_InterstitialAd *)interstitialAd {
    DomobBiddingRequest *request = [[DomobBiddingManager sharedInstance] getRequestItemWithUnitID:self.unitID];
    NSLog(@"request.unitGroup.bidTokenTime = %f",request.unitGroup.bidTokenTime);
    ATBidInfo *bidInfo = [ATBidInfo bidInfoC2SWithPlacementID:request.placementID unitGroupUnitID:request.unitGroup.unitID adapterClassString:request.unitGroup.adapterClassString price:[NSString stringWithFormat:@"%ld",interstitialAd.bidPrice] currencyType:ATBiddingCurrencyTypeCNYCents expirationInterval:request.unitGroup.bidTokenTime customObject:interstitialAd];
    bidInfo.networkFirmID = request.unitGroup.networkFirmID;
    if(request.bidCompletion){
        request.bidCompletion(bidInfo, nil);
    }
}
- (void)interstitialAdDidFailToLoadWithError:(NSError *)error{
    
}

#pragma - banner
- (void)bannerAdDidLoad :(DM_BannerAd*)bannerAd{
    DomobBiddingRequest *request = [[DomobBiddingManager sharedInstance] getRequestItemWithUnitID:self.unitID];
    NSLog(@"request.unitGroup.bidTokenTime = %f",request.unitGroup.bidTokenTime);
    ATBidInfo *bidInfo = [ATBidInfo bidInfoC2SWithPlacementID:request.placementID unitGroupUnitID:request.unitGroup.unitID adapterClassString:request.unitGroup.adapterClassString price:[NSString stringWithFormat:@"%ld",bannerAd.bidPrice] currencyType:ATBiddingCurrencyTypeCNYCents expirationInterval:request.unitGroup.bidTokenTime customObject:bannerAd];
    bidInfo.networkFirmID = request.unitGroup.networkFirmID;
    if(request.bidCompletion){
        request.bidCompletion(bidInfo, nil);
    }
}
- (void)bannerAdDidFailToLoadWithError:(NSError *)error{
    
}

#pragma - rewardVideo
- (void)rewardVideoAdDidLoad:(nonnull DM_RewardVideoAd *)rewardVideoAd {
    DomobBiddingRequest *request = [[DomobBiddingManager sharedInstance] getRequestItemWithUnitID:self.unitID];
    NSLog(@"request.unitGroup.bidTokenTime = %f",request.unitGroup.bidTokenTime);
    ATBidInfo *bidInfo = [ATBidInfo bidInfoC2SWithPlacementID:request.placementID unitGroupUnitID:request.unitGroup.unitID adapterClassString:request.unitGroup.adapterClassString price:[NSString stringWithFormat:@"%ld",rewardVideoAd.bidPrice] currencyType:ATBiddingCurrencyTypeCNYCents expirationInterval:request.unitGroup.bidTokenTime customObject:rewardVideoAd];
    bidInfo.networkFirmID = request.unitGroup.networkFirmID;
    if(request.bidCompletion){
        request.bidCompletion(bidInfo, nil);
    }
}
- (void)rewardVideoAdDidFailToLoadWithError:(NSError *)error{
    
}

#pragma - feedAd
- (void)feedAdDidLoad:(nonnull DM_FeedAd *)feedAd {
    DomobBiddingRequest *request = [[DomobBiddingManager sharedInstance] getRequestItemWithUnitID:self.unitID];
    NSLog(@"request.unitGroup.bidTokenTime = %f",request.unitGroup.bidTokenTime);
    ATBidInfo *bidInfo = [ATBidInfo bidInfoC2SWithPlacementID:request.placementID unitGroupUnitID:request.unitGroup.unitID adapterClassString:request.unitGroup.adapterClassString price:[NSString stringWithFormat:@"%ld",feedAd.bidPrice] currencyType:ATBiddingCurrencyTypeCNYCents expirationInterval:request.unitGroup.bidTokenTime customObject:feedAd];
    bidInfo.networkFirmID = request.unitGroup.networkFirmID;
    if(request.bidCompletion){
        request.bidCompletion(bidInfo, nil);
    }
}
- (void)feedAdDidFailToLoadWithError:(nonnull NSError *)error {
    
}
@end
