//
//  DomobConst.h
//  DMengAdSDK
//
//  Created by 刘士林 on 2024/5/20.
//

#ifndef DomobConst_h
#define DomobConst_h

//聚合SDK事件上报：
//请求渠道事件上报
static NSString *const DMeng_RequestChannel_Event_Reporting = @"https://u-sdk-track.domob.cn/union/req";
//渠道出价上报
static NSString *const DMeng_BiddingChannel_Event_Reporting = @"https://u-sdk-track.domob.cn/union/bid";
//竞价成功事件
static NSString *const DMeng_BiddingSuccess_Event_Reporting = @"https://u-sdk-track.domob.cn/union/win";
//竞价失败事件
static NSString *const DMeng_BiddingFail_Event_Reporting = @"https://u-sdk-track.domob.cn/union/lwin";
//曝光事件上报
static NSString *const DMeng_Exposure_Event_Reporting = @"https://u-sdk-track.domob.cn/union/imp";
//点击事件上报
static NSString *const DMeng_Click_Event_Reporting = @"https://u-sdk-track.domob.cn/union/clk";
//请求统计
static NSString *const DMeng_Rawreq_Event_Reporting = @"https://u-sdk-track.domob.cn/union/rawreq";


#endif /* DomobConst_h */
