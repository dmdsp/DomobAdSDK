//
//  DomobBiddingManager.h
//  DMAd
//
//  Created by 刘士林 on 2024/8/29.
//

#import <Foundation/Foundation.h>
#import "DomobBiddingRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface DomobBiddingManager : NSObject
+ (instancetype)sharedInstance;

- (void)startWithRequestItem:(DomobBiddingRequest *)request;

- (DomobBiddingRequest *)getRequestItemWithUnitID:(NSString *)unitID;

- (void)removeRequestItmeWithUnitID:(NSString *)unitID;

- (void)removeBiddingDelegateWithUnitID:(NSString *)unitID; 

@end

NS_ASSUME_NONNULL_END
