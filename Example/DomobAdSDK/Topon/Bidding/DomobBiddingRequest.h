//
//  DomobBiddingRequest.h
//  DMAd
//
//  Created by 刘士林 on 2024/8/28.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ESCAdFormat) {
    ESCAdFormatSplash = 0,
    ESCAdFormatInterstitial = 1,
    ESCAdFormatBanner = 2,
    ESCAdFormatRewardedVideo = 3,
    ESCAdFormatFeed= 4,
};


@interface DomobBiddingRequest : NSObject
@property(nonatomic, strong) id customObject;

@property(nonatomic, strong) ATUnitGroupModel *unitGroup;

@property(nonatomic, strong) ATAdCustomEvent *customEvent;

@property(nonatomic, copy) NSString *unitID;
@property(nonatomic, copy) NSString *placementID;

@property(nonatomic, copy) NSDictionary *extraInfo;

@property(nonatomic, copy) void(^bidCompletion)(ATBidInfo * _Nullable bidInfo, NSError * _Nullable error);

@property(nonatomic, assign) ESCAdFormat adType;

@end

NS_ASSUME_NONNULL_END
