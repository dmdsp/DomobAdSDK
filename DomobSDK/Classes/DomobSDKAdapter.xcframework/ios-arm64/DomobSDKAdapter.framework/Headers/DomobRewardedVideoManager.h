//
//  DomobRewardedVideoManager.h
//  DMengAdSDK
//
//  Created by 刘士林 on 2024/6/4.
//

#import <Foundation/Foundation.h>
#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DM_Macro.h>
#import <DMAdSDK/DMUnionModel.h>
#import <DomobSDKAdapter/DomobRewardedVideoAdapter.h>

NS_ASSUME_NONNULL_BEGIN
@interface DomobRewardedVideoManager : NSObject
typedef void(^DomobRewardedVideoManagerCompletion)(DomobRewardedVideoAdapter * rewardedVideoAdapter);
/// 初始化激励视频和配置、代理
/// - Parameter delegate: 代理
/// - Parameter slotID: 广告位id
/// - Parameter model:  额外的数据
- (void)loadRewardedVideoAdTemplateAdWithSlotID:(NSString *)slotID withRewardVideoModel:(DomobRewardVideoModel*)model completion:(DomobRewardedVideoManagerCompletion)completion;
@end

NS_ASSUME_NONNULL_END
