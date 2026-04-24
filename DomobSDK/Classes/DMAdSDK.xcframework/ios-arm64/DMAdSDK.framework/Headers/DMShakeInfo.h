//
//  DMShakeInfo.h
//  DMAdSDK
//

#import <Foundation/Foundation.h>
@class DspConfig;

NS_ASSUME_NONNULL_BEGIN

@interface DMShakeInfo : NSObject

@property (nonatomic, assign) double angle;
@property (nonatomic, assign) double acceleration;
@property (nonatomic, assign) double time;

+ (nullable DMShakeInfo *)shakeInfoWithOption:(DspConfig *)option;

@end

NS_ASSUME_NONNULL_END
