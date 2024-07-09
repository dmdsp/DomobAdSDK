//
//  DomobHTTPClient.h
//  DMAdSDKAdapter
//
//  Created by 刘士林 on 2024/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomobHTTPClient : NSObject
-(void)get:(NSString *)url unionSdkTracker:(NSString*)sdkTracker;
@end

NS_ASSUME_NONNULL_END
