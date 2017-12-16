//
//  ThreePartiesShareTools.m
//  EasyCarToBuy
//
//  Created by HJ on 2017/9/27.
//  Copyright © 2017年 HYS. All rights reserved.
//

#import "ThreePartiesShareTools.h"

@implementation ThreePartiesShareTools
/*
+ (void)ShareToWXWith:(NSString *)title descri:(NSString *)destriString url:(NSString *)url img:(UIImage *)img
{
    WXMediaMessage * mess = [WXMediaMessage message];
    mess.title = title;
    NSString * descri = destriString;
    mess.description = descri;
    [mess setThumbImage:img];
    WXWebpageObject * webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl= url;
    mess.mediaObject = webpageObject;
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = mess;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

+ (void)ShareToWXZoneWith:(NSString *)title descri:(NSString *)destriString url:(NSString *)url img:(UIImage *)img
{
    WXMediaMessage * mess = [WXMediaMessage message];
    mess.title = title;
    NSString * descri = destriString;
    mess.description = descri;
    [mess setThumbImage:img];
    WXWebpageObject * webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl= url;
    mess.mediaObject = webpageObject;
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = mess;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

+ (void)ShareQQ:(NSString *)title descri:(NSString *)des url:(NSString *)url  imgUrl:(NSString *)imgurl
{
    QQApiNewsObject *msgContentObj =
    [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:des previewImageURL:[NSURL URLWithString:imgurl]];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:msgContentObj];
    [QQApiInterface sendReq:req];
}

+ (void)ShareQQZone:(NSString *)title descri:(NSString *)des url:(NSString *)url  imgUrl:(NSString *)imgurl
{
    QQApiNewsObject *msgContentObj =
    [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:des previewImageURL:[NSURL URLWithString:imgurl]];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:msgContentObj];
    [QQApiInterface SendReqToQZone:req];
}

+ (void)ShareWBTitle:(NSString *)title url:(NSString *)url scope:(NSString *)sco imgData:(NSData *)imgdata
{
    WBAuthorizeRequest *wbRequest = [WBAuthorizeRequest request];
    wbRequest.redirectURI = url;
    wbRequest.scope = sco;
    WBImageObject *imageObject = [WBImageObject object];
    imageObject.imageData = imgdata;
    WBMessageObject *messageObject = [WBMessageObject message];
    messageObject.text = [NSString stringWithFormat:@"%@  %@", title,url];
    messageObject.imageObject = imageObject;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:messageObject authInfo:wbRequest access_token:nil];
    [WeiboSDK sendRequest:request];
}

//+ (void)shareToAilPayWithTitle:(NSString *)title url:(NSString *)url des:(NSString *)des imgUrl:(NSString *)imgUrl type:(int)type
//{
//    //  创建消息载体 APMediaMessage 对象
//    APMediaMessage *message = [[APMediaMessage alloc] init];
//
//    message.title = title;
//    message.desc = des;
//    message.thumbUrl = imgUrl;
//
//    //  创建网页类型的消息对象
//    APShareWebObject *webObj = [[APShareWebObject alloc] init];
//    webObj.wepageUrl = url;
//    //  回填 APMediaMessage 的消息对象
//    message.mediaObject = webObj;
//
//    //  创建发送请求对象
//    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
//    //  填充消息载体对象
//    request.message = message;
//    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至现在版本，分享入口已合并，这个scene并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题、建议还是照常传入
//    request.scene = type;
//    //  发送请求
//    BOOL result = [APOpenAPI sendReq:request];
//    if (!result) {
//        //失败处理
//        NSLog(@"发送失败");
//    }
//}
*/
@end
