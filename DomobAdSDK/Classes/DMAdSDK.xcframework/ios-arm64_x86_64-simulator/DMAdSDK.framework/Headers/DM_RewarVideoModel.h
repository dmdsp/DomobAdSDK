//
//  DM_RewarVideoModel.h
//  DMAdSDK
//
//  Created by 刘士林 on 2024/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DM_RewarVideoModel : NSObject
// 用户唯一ID
@property (nonatomic, copy) NSString *userId;
// 激励视频获取奖励时间,默认15秒
@property (nonatomic, assign) int rewardTime;
// 拓展参数
@property (nonatomic, copy) NSString *extra;


@end

NS_ASSUME_NONNULL_END
