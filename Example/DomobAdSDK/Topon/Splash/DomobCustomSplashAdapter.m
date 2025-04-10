//
//  DomobCustomSplashAdapter.m
//  DMAd
//
//  Created by 刘士林 on 2024/8/16.
//

#import "DomobCustomSplashAdapter.h"
#import <AnyThinkSplash/AnyThinkSplash.h>
#import "DomobSplashCustomEvent.h"
#import <DMAdSDK/DM_SplashAd.h>
#import <DMAdSDK/DMAds.h>
#import "DomobBiddingRequest.h"
#import "DomobBiddingManager.h"
#import "DomobBiddingDelegate.h"
#import <AnyThinkSDK/ATAdErrorCode.h>

@interface DomobCustomSplashAdapter ()<ATAdAdapter>
@property (nonatomic, strong) DomobSplashCustomEvent *customEvent;
@property (nonatomic, strong) DM_SplashAd *splashAd;

@end
@implementation DomobCustomSplashAdapter
// 注册三方广告平台的SDK
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
        request.adType = ESCAdFormatSplash;
        
        [biddingManage startWithRequestItem:request];
    });
    
}


+ (void)sendWinnerNotifyWithCustomObject:(id)customObject secondPrice:(NSString*)price userInfo:(NSDictionary<NSString *, NSString *> *)userInfo{
    //customObject为当广告对象
    if ([customObject isKindOfClass:[DM_SplashAd class]]) {
        DM_SplashAd * ad = customObject;
        [ad biddingSplashSuccess:price.integerValue];
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

+ (void)sendBackLossPrice:(DM_SplashAd *)ad code:(DMAdBiddingCode)code price:(NSInteger)price {
    [ad biddingSplashFailed:price Code:code];
}
// 竞价完成并发送了ATBidInfo给SDK后，来到该方法，或普通广告源加载广告来到该方法
- (void)loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    NSDictionary *extra = localInfo;
    NSTimeInterval tolerateTimeout = localInfo[kATSplashExtraTolerateTimeoutKey] ? [localInfo[kATSplashExtraTolerateTimeoutKey] doubleValue] : 5.0;
    if (tolerateTimeout > 0) {
        _customEvent = [[DomobSplashCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
        _customEvent.requestCompletionBlock = completion;
        
        DomobBiddingRequest *request = [[DomobBiddingManager sharedInstance] getRequestItemWithUnitID:serverInfo[@"unitid"]];
        if (request) { //竞价失败不会进入该方法，所以处理竞价成功的逻辑
            
            if (request.customObject != nil) { // load secced 且 广告数据可用(原则上是检查广告是否可用的，TM并没有提供所以使用检查是否广告对象来替代)
                self.splashAd = request.customObject;
                [self.splashAd setValue:_customEvent forKey:@"delegate"];
                //                self.splashAd.delegate = _customEvent;
                // 返回加载完成
                [_customEvent trackSplashAdLoaded:self.splashAd];
            } else { // 广告数据不可用
                NSError *error = [NSError errorWithDomain:ATADLoadingErrorDomain code:ATAdErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load splash.", NSLocalizedFailureReasonErrorKey:@"It took too long to load placement stragety."}];
                // 返回加载失败
                [_customEvent trackSplashAdLoadFailed:error];
            }
            [[DomobBiddingManager sharedInstance] removeRequestItmeWithUnitID:serverInfo[@"unitid"]];
        } else {
            // 普通瀑布流的广告配置，进行加载广告
            dispatch_async(dispatch_get_main_queue(), ^{
                self.splashAd = [DM_SplashAd new] ;
                [self.splashAd loadSplashAdTemplateAdWithSlotID:serverInfo[@"unitid"] adSize:CGSizeMake(0, [UIScreen mainScreen].bounds.size.height) delegate:self.customEvent];
            });
        }
    } else {
        completion(nil, [NSError errorWithDomain:ATADLoadingErrorDomain code:ATAdErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load splash.", NSLocalizedFailureReasonErrorKey:@"It took too long to load placement stragety."}]);
    }
}

+ (BOOL)adReadyWithCustomObject:(nonnull id)customObject info:(nonnull NSDictionary *)info {
    return customObject;
}
+ (void)showSplash:(ATSplash *)splash localInfo:(NSDictionary *)localInfo delegate:(id<ATSplashDelegate>)delegate {
    UIWindow *window = localInfo[kATSplashExtraWindowKey];
    DM_SplashAd  *splashView = splash.customObject;
    [window addSubview:splashView.dmSplashView];
}
@end
