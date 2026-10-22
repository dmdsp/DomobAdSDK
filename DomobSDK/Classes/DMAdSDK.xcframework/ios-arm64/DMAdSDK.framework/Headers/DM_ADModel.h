//
//  DM_ADModel.h
///  DMAd
//
//  Created by 刘士林 on 2024/3/14.
//

#import <Foundation/Foundation.h>

@class DM_AdsConfig;
@class DM_AdsConfiguration;

@interface DM_ADModel : NSObject
/**
 广告资源的链接
 */
@property (nonatomic,copy) NSString *picture_url;
/**
 大小
 */
@property (nonatomic,assign) CGSize adSize;
/**
 打开外部应用
 */
@property (nonatomic,copy) NSString *universal_link;
/**
 appId
 */
@property (nonatomic,copy) NSString *appId;
/**
 点击广告打开落地页
 */
@property (nonatomic,copy) NSString *link_url;
/**
 微信小程序
 */
@property (nonatomic,copy) NSString *wxId;
/**
 标题
 */
@property (nonatomic,copy) NSString *title;
/**
 app名字
 */
@property (nonatomic,copy) NSString *appName;
/**
 app图片
 */
@property (nonatomic,copy) NSString *appImage;
/**
 上报地址-不喜欢
 */
@property (nonatomic,copy) NSArray *eventTrackUrl;
/**
 打开u-link的上报
 */
@property (nonatomic,copy) NSArray *eventDeeplinkUrlArr;
/**
 点击上报
 */
@property (nonatomic,copy) NSArray *clickTrackingURL;
/**
 检测上报,在显示的时候调用
 */
@property (nonatomic,copy) NSArray *impressionTrackingURLArray;

/** 视频缩略图 */
@property (nonatomic,copy) NSString *videoCover;

/** 视频素材地址 */
@property (nonatomic,copy) NSString *videoURL;

/** 素材类型: 2=图片 4=视频 */
@property (nonatomic, assign) int32_t creativeType;

/** 广告描述 */
@property (nonatomic,copy) NSString *description_p;
/** 缓存到本地的视频地址 */
@property (nonatomic,strong) NSURL *localVideoURL;
/** 按钮的文字 */
@property (nonatomic,copy) NSString *adWords;
/** 陀螺仪的灵敏度 0 是隐藏 */
@property (nonatomic,copy) NSString * sensitivity;
//控制点击关闭按钮时候的弹窗
@property (nonatomic, assign) bool isHidden;
//dspId
@property (nonatomic, assign) int dspId;
/** 素材尺寸宽度 */
@property(nonatomic, assign) int32_t width;

/** 素材尺寸高度 */
@property(nonatomic, assign) int32_t height;

/** 视频时长，单位毫秒 */
@property(nonatomic, assign) int32_t videoDuration;

@property(nonatomic, strong) DM_AdsConfig *option;

/** 广告随素材下发的完整配置 */
@property(nonatomic, strong, nullable) DM_AdsConfiguration *configuration;

/** 关闭按钮 dislike 选项，key 为 int 类型选项 ID，value 为展示文案 */
@property(nonatomic, strong, nullable) NSMutableDictionary<NSNumber*, NSString*> *closeButtons;

/** 广告来源标识 */
@property (nonatomic,copy) NSString *adSource;

/** 开始播放上报URL（type=1） */
@property (nonatomic, copy) NSArray *eventTrackStartUrl;
/** 视频广告有效上报URL（type=2） */
@property (nonatomic, copy) NSArray *eventTrackValidUrl;
/** 视频播放四分之一上报URL（type=9） */
@property (nonatomic, copy) NSArray *eventTrackQ1Url;
/** 播放一半上报URL（type=7） */
@property (nonatomic, copy) NSArray *eventTrackHalfUrl;
/** 播放四分之三上报URL（type=10） */
@property (nonatomic, copy) NSArray *eventTrackQ3Url;
/** 视频播放完成上报URL（type=3） */
@property (nonatomic, copy) NSArray *eventTrackCompleteUrl;
/** 播放3秒上报URL（type=11） */
@property (nonatomic, copy) NSArray *eventTrack3sUrl;
/** 播放5秒上报URL（type=12） */
@property (nonatomic, copy) NSArray *eventTrack5sUrl;
/** 切后台/关闭上报URL（type=8） */
@property (nonatomic, copy) NSArray *eventTrackPauseUrl;

@end
