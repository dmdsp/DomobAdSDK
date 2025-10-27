//
//  DM_BannerView.h
//  DMAdSDK
//
//  Created by 刘士林 on 2024/3/28.
//

#import <UIKit/UIKit.h>
#import <DMAdSDK/DM_BannerAd.h>

NS_ASSUME_NONNULL_BEGIN

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
@property (nonatomic, weak) UIViewController *presentAdViewController;

//广告
@property (nonatomic, strong) UIButton*adBtn;
//关闭按钮
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, copy) ClickLinkEvent linkEvent;
@property (nonatomic, copy) ClickCloseEvent closeEvent;
@property (nonatomic, copy) DidShowEvent showEvent;
@property (nonatomic, copy) DetailViewDidClose detailViewDidClose;
@property (nonatomic, copy) DetailViewDidPresentScreen detailViewDidPresentScreen;
@property (nonatomic, assign) CGPoint startScreenPoint;
@property (nonatomic, assign) CGPoint endScreenPoint;
@property (nonatomic, assign) CGPoint startViewPoint;
@property (nonatomic, assign) CGPoint endViewPoint;
-(instancetype)initWithBannerAdTemplate;
//关闭当前view
- (void)dismissADView;
@end

NS_ASSUME_NONNULL_END
