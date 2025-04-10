//
//  DomobNativeCustomEvent.h
//  DMAd
//
//  Created by 刘士林 on 2024/8/27.
//

#import <AnyThinkNative/AnyThinkNative.h>
#import <DMAdSDK/DM_FeedAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomobNativeCustomEvent : ATNativeADCustomEvent <DMFeedAdDelegate>
- (void)feedRendering:(DM_FeedAd *)feedAd isDmTemplateAd:(BOOL)isdmtemplatead;
@end

NS_ASSUME_NONNULL_END
