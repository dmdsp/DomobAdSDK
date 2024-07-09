//
//  DomobDelegateCall.h
//  DMengAdSDK
//
//  Created by 刘士林 on 2024/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomobDelegateCall : NSObject
@property (strong, nonatomic) NSString *methodIdentifier;
@property (strong, nonatomic) id parameter;
@end

NS_ASSUME_NONNULL_END
