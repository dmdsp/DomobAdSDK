//
//  DMUnionModel.h
//  DMAdSDK
//
//  Created by 刘士林 on 2024/5/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMUnionModel : NSObject
/** 交易所ID */
@property(nonatomic, assign) int exchangeId;
/** ADX应用ID */
@property(nonatomic, assign) int applicationId;
/** appid */
@property(nonatomic, copy) NSString * unionAppid;
/** template */
@property(nonatomic, copy) NSDictionary *templateDic;
/** profitMargin */
@property(nonatomic, copy) NSDictionary *profitMarginDic;
/** version */
@property(nonatomic, copy) NSString *version;
/** pub_time */
@property(nonatomic, assign) int64_t pubTime;
/** 开屏并发请求超时时间 */
@property(nonatomic, assign) int32_t splashReqTimeout;
/** 信息流并发请求超时时间 */
@property(nonatomic, assign) int32_t feedReqTimeout;
/** banner并发请求超时时间 */
@property(nonatomic, assign) int32_t bannerReqTimeout;
/** 插屏并发请求超时时间 */
@property(nonatomic, assign) int32_t interactionReqTimeout;
/** 激励视频并发请求超时时间 */
@property(nonatomic, assign) int32_t rewardVideoReqTimeout;
/** 缓存池广告有效期,单位毫秒 */
@property(nonatomic, assign) int32_t cacheValidity;

@property(nonatomic, strong) NSMutableArray * adaptersArray;

@end
@interface DMUnionDspTrackerModel : NSObject
@property(nonatomic, copy) NSString * unionAppid;
@property(nonatomic, copy) NSString * unionAdZoneId;
@property(nonatomic, assign) uint64_t bid;
@property(nonatomic, assign) int64_t bidTs;
@property(nonatomic, assign) int32_t profit;
@property(nonatomic, assign) int32_t unionDspId;

@end
@class DMUnionDspTrackerModel;
@interface DMUnionTrackerModel : NSObject
@property(nonatomic, copy) NSString * slotID;
@property(nonatomic, assign) uint64_t bid;
@property(nonatomic, strong) NSMutableArray <DMUnionDspTrackerModel *>* dspTrackerArr;

@end
NS_ASSUME_NONNULL_END
