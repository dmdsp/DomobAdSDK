//
//  DomobSplashManager.h
//  DMengAdSDK
//
//  Created by 刘士林 on 2024/5/10.
//

#import <Foundation/Foundation.h>
#import <DMAdSDK/DMAds.h>
#import <DMAdSDK/DM_Macro.h>
#import <DMAdSDK/DMUnionModel.h>
#import <DomobSDKAdapter/DomobSplashAdapter.h>

NS_ASSUME_NONNULL_BEGIN
@interface DomobSplashManager : NSObject
typedef void(^DomobSplashManagerCompletion)(DomobSplashAdapter * splashAdapter);

/// 初始化开屏广告
/// - Parameter completion: 加载完成后返回的对象
/// - Parameter slotID: 广告位id
/// - Parameter adSize: 尺寸,必须>=屏幕高度的75%，如果高度<75%，将会以屏幕实际高度渲染，可能会导致图片变形或影响广告渲染速度
- (void)loadSplashAdTemplateAdWithSlotID:(nonnull NSString *)slotID adSize:(CGSize)adSize completion:(DomobSplashManagerCompletion)completion;
@end


NS_ASSUME_NONNULL_END
