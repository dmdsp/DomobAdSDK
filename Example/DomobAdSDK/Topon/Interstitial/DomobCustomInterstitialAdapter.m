//
//  DomobCustomInterstitialAdapter.m
//  DMAd
//
//  Created by 刘士林 on 2024/8/27.
//

#import "DomobCustomInterstitialAdapter.h"
#import "DomobInterstitialCustomEvent.h"
#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DM_InterstitialAd.h>
#import "DomobBiddingRequest.h"
#import "DomobBiddingManager.h"
#import "DomobBiddingDelegate.h"
@interface DomobCustomInterstitialAdapter()
@property (nonatomic, strong) DomobInterstitialCustomEvent *customEvent;
@property (nonatomic, strong) DM_InterstitialAd * interstitialAd;

@end
@implementation DomobCustomInterstitialAdapter
-(instancetype) initWithNetworkCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo {
    self = [super init];
    if (self != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[DMAds shareInstance] initSDK];
        });  
    }
    return self;
}
+ (void)bidRequestWithPlacementModel:(ATPlacementModel*)placementModel unitGroupModel:(ATUnitGroupModel*)unitGroupModel info:(NSDictionary*)info completion:(void(^)(ATBidInfo *bidInfo, NSError *error))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[DMAds shareInstance] initSDK];
        
        DomobBiddingManager *biddingManage = [DomobBiddingManager sharedInstance];
        
        DomobBiddingRequest *request = [DomobBiddingRequest new];
        request.unitGroup = unitGroupModel;
        request.placementID = placementModel.placementID;
        request.bidCompletion = completion;
        request.unitID = info[@"unitid"];
        request.extraInfo = info;
        request.adType = ESCAdFormatInterstitial;
        
        [biddingManage startWithRequestItem:request];
    });
}

+ (void)sendWinnerNotifyWithCustomObject:(id)customObject secondPrice:(NSString*)price userInfo:(NSDictionary<NSString *, NSString *> *)userInfo{
    //customObject为当广告对象
    if ([customObject isKindOfClass:[DM_InterstitialAd class]]) {
        DM_InterstitialAd * ad = customObject;
        [ad biddingInterstitialSuccess:price.integerValue];
    }
}

+ (void)sendLossNotifyWithCustomObject:(nonnull id)customObject lossType:(ATBiddingLossType)lossType winPrice:(nonnull NSString *)price userInfo:(NSDictionary *)userInfo{
    //customObject为当广告对象，lossType 为 bid失败原因
    if ([customObject isKindOfClass:[DM_FeedAd class]]) {
        
        switch (lossType) {
            case ATBiddingLossWithLowPriceInNormal:
            {
                [self sendBackLossPrice:customObject code:DMAdBiddingCodeFloorPriceOvershoot price:price.integerValue];
            }
                break;
            case ATBiddingLossWithLowPriceInHB:
            {
                [self sendBackLossPrice:customObject code:DMAdBiddingCodeFloorPriceOvershoot price:price.integerValue];
            }
                break;
            case ATBiddingLossWithBiddingTimeOut:
            {
                [self sendBackLossPrice:customObject code:DMAdBiddingCodeTimeout price:price.integerValue];
            }
                break;
            case ATBiddingLossWithExpire:
            {
                [self sendBackLossPrice:customObject code:DMAdBiddingCodeUnknown price:price.integerValue];
            }
                break;
            case ATBiddingLossWithFloorFilter:
            {
                [self sendBackLossPrice:customObject code:DMAdBiddingCodeFloorPriceOvershoot price:price.integerValue];
            }
                break;
                
            default:
                break;
        }
    }
}

+ (void)sendBackLossPrice:(DM_InterstitialAd *)ad code:(DMAdBiddingCode)code price:(NSInteger)price {
    [ad biddingInterstitialFailed:price Code:code];
}
-(void) loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    
    NSDictionary *extra = localInfo;
    
    _customEvent = [[DomobInterstitialCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
    _customEvent.requestCompletionBlock = completion;
    
    DomobBiddingRequest *request = [[DomobBiddingManager sharedInstance] getRequestItemWithUnitID:serverInfo[@"unitid"]];
    if (request) { //竞价失败不会进入该方法，所以处理竞价成功的逻辑
        
        if (request.customObject != nil) { // load secced 且 广告数据可用(原则上是检查广告是否可用的，TM并没有提供所以使用检查是否广告对象来替代)
            self.interstitialAd = request.customObject;
            [self.interstitialAd setValue:_customEvent forKey:@"delegate"];
            //                self.splashAd.delegate = _customEvent;
            // 返回加载完成
            [_customEvent trackInterstitialAdDataLoadSuccess:self.interstitialAd adExtra:extra];
        } else { // 广告数据不可用
            NSError *error = [NSError errorWithDomain:ATADLoadingErrorDomain code:ATAdErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load splash.", NSLocalizedFailureReasonErrorKey:@"It took too long to load placement stragety."}];
            // 返回加载失败
            [_customEvent trackInterstitialAdLoadFailed:error];
        }
        [[DomobBiddingManager sharedInstance] removeRequestItmeWithUnitID:serverInfo[@"unitid"]];
    } else {
        // 普通瀑布流的广告配置，进行加载广告
        dispatch_async(dispatch_get_main_queue(), ^{
            self.interstitialAd = [[DM_InterstitialAd alloc] loadInterstitialAdTemplateAdWithSlotID:serverInfo[@"unitid"] delegate:_customEvent];
            
        });
    }
}
+(BOOL) adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info {
    return YES;
}


+(void) showInterstitial:(ATInterstitial*)interstitial inViewController:(UIViewController*)viewController delegate:(id<ATInterstitialDelegate>)delegate {
    DM_InterstitialAd *interstitialAd = interstitial.customObject;
    [interstitialAd showInterstitialViewInRootViewController:viewController];
}
@end
