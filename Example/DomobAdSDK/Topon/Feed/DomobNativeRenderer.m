//
//  DomobNativeRenderer.m
//  DMAd
//
//  Created by 刘士林 on 2024/8/27.
//

#import "DomobNativeRenderer.h"
#import "DomobNativeCustomEvent.h"

@interface DomobNativeRenderer ()
@property (nonatomic, strong) DomobNativeCustomEvent *customEvent;

@end
@implementation DomobNativeRenderer

-(void)renderOffer:(ATNativeADCache *)offer {
    [super renderOffer:offer];
    _customEvent = offer.assets[kATAdAssetsCustomEventKey];
    _customEvent.adView = self.ADView;
    self.ADView.customEvent = _customEvent;
    DM_FeedAd *feedAd = (DM_FeedAd *)offer.assets[kATAdAssetsCustomObjectKey];
    [self.ADView addSubview:(UIView*)feedAd.feedView];
}
@end
