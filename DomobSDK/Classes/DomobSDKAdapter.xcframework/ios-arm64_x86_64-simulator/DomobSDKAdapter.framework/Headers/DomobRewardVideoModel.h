//
//  DomobRewardVideoModel.h
//  DMengAdSDK
//
//  Created by 刘士林 on 2024/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomobRewardVideoModel : NSObject
// 用户唯一ID
@property (nonatomic, copy) NSString *userId;
// 激励视频获取奖励时间,默认15秒
@property (nonatomic, assign) int rewardTime;
// 拓展参数
@property (nonatomic, copy) NSString *extra;
// 奖励名称
@property (nonatomic, copy) NSString *rewardName;
// 奖励数量
@property (nonatomic, assign) NSInteger  rewardAmount;
@end

NS_ASSUME_NONNULL_END
