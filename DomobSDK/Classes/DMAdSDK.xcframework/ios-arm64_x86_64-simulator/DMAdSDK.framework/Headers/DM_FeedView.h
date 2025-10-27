//
//  DM_FeedView.h
//  DMAdSDK
//
//  Created by 刘士林 on 2024/3/28.
//

#import <UIKit/UIKit.h>
#import <DMAdSDK/DM_FeedAd.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN
// 定义样式模板枚举
typedef NS_ENUM(NSInteger, DMFeedAdTemplate) {
//    左图右文
    DMFeedAdTemplateStyle1 = 1,
//    右图左文
    DMFeedAdTemplateStyle2 = 2,
//    上文下图
    DMFeedAdTemplateStyle3 = 3,
//    上图下文
    DMFeedAdTemplateStyle4 = 4,
//    自定义 会返回当前view 由用户来布局
    DMFeedAdTemplateCustom = 5
};

@class DM_ADModel;

typedef void(^ClickLinkEvent)(void);
typedef void(^ClickCloseEvent)(void);
typedef void(^DidShowEvent)(void);
typedef void(^DetailViewDidClose)(void);
typedef void(^DetailViewDidPresentScreen)(void);

@interface DM_FeedView : UIView

@property (nonatomic, assign) CGPoint startScreenPoint;
@property (nonatomic, assign) CGPoint endScreenPoint;
@property (nonatomic, assign) CGPoint startViewPoint;
@property (nonatomic, assign) CGPoint endViewPoint;
@property(nonatomic,assign) int sensitivity;
//是否是从摇一摇来的点击
@property (nonatomic, assign) bool isFromShake;

//背景view
@property (nonatomic, strong) UIView *bgView;
//背景image
@property (nonatomic, strong) UIImageView *adImageView;
//摇一摇gif
@property (nonatomic, strong) UIImageView *shakeView;
@property (nonatomic, strong) DM_ADModel *adModel;
//查看详情按钮
@property (nonatomic, strong) UIButton *jumpBtn;
//广告
@property (nonatomic, strong) UIButton*adBtn;
//标题
@property (nonatomic, strong) UILabel *titleLab;
//关闭按钮
@property (nonatomic, strong) UIButton *closeBtn;
//app图片
@property (nonatomic, strong) UIImageView *appImageView;
//app名字
@property (nonatomic, strong) UILabel *appLab;
//当前的渲染模版
@property (nonatomic, assign) DMFeedAdTemplate adTemplate;
@property (nonatomic, weak) UIViewController *presentAdViewController;

//player
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;


@property (nonatomic, copy) ClickLinkEvent linkEvent;
@property (nonatomic, copy) ClickCloseEvent closeEvent;
@property (nonatomic, copy) DidShowEvent showEvent;
@property (nonatomic, copy) DetailViewDidClose detailViewDidClose;
@property (nonatomic, copy) DetailViewDidPresentScreen detailViewDidPresentScreen;
//广告创意类型
@property (nonatomic, assign) DMAdCreativeType creativeType;

-(instancetype)initWithFeedAdTemplate:(DMFeedAdTemplate)adTemplate;
//关闭当前view
- (void)dismissADView;
//注册点击事件,如果未调用或者数组为空将默认整个view可以点击
- (void)registerClickableViews:(NSArray<__kindof UIView *> *_Nullable)clickableViews;
//移除点击
- (void)removeClickableViews;

@end

NS_ASSUME_NONNULL_END
