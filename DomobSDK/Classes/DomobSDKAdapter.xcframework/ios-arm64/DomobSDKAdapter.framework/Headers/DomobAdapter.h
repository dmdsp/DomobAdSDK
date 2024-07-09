//
//  DomobAdapter.h
//  DMengAdSDK
//
//  Created by 刘士林 on 2024/5/11.
//

#import <Foundation/Foundation.h>
#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DMUnionModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomobAdapter : NSObject

// 单例
+(instancetype)shareInstance;

//SDK 初始化
-(void)initUnionSDKCompletion:(CompletionEvent) completion;

//
- (NSTimeInterval)getCurrentTimeInterval;
@end

NS_ASSUME_NONNULL_END
