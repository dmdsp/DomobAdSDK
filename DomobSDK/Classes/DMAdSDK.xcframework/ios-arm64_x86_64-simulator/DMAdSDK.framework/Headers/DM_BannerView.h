//
//  DM_BannerView.h
//  DMAdSDK
//
//  Created by 刘士林 on 2024/3/28.
//

#import <UIKit/UIKit.h>
#import <DMAdSDK/DM_BannerAd.h>

NS_ASSUME_NONNULL_BEGIN
// 定义样式模板枚举
typedef NS_ENUM(NSInteger, DMBannerAdTemplate) {
    // 模版
    DMBannerAdTemplateStyle = 1,
    // 自渲染
    DMBannerAdTemplateCustom = 2
};

@class DM_ADModel;

typedef void(^ClickLinkEvent)(void);
typedef void(^ClickCloseEvent)(void);
typedef void(^DidShowEvent)(void);
typedef void(^DetailViewDidClose)(void);
typedef void(^DetailViewDidPresentScreen)(void);

@interface DM_BannerView : UIView
//背景image
@property (nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, strong) DM_ADModel *adModel;
@property (nonatomic, strong) UIViewController *presentAdViewController;

//广告
@property (nonatomic, strong) UILabel *adLab;
//关闭按钮
@property (nonatomic, strong) UIButton *closeBtn;
//当前的渲染模版
@property (nonatomic, assign) DMBannerAdTemplate adTemplate;

@property (nonatomic, copy) ClickLinkEvent linkEvent;
@property (nonatomic, copy) ClickCloseEvent closeEvent;
@property (nonatomic, copy) DidShowEvent showEvent;
@property (nonatomic, copy) DetailViewDidClose detailViewDidClose;
@property (nonatomic, copy) DetailViewDidPresentScreen detailViewDidPresentScreen;

-(instancetype)initWithBannerAdTemplate:(DMBannerAdTemplate)adTemplate;

@end

NS_ASSUME_NONNULL_END
