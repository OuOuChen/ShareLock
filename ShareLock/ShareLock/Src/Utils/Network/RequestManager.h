//
//  RequestManager.h
//  HXBaseProjectDemo
//
//  Created by 陈区 on 2017/1/16.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface RequestManager : AFHTTPSessionManager



/**
  创建RequestManager单例

 @return requestManager单例对象
 */
+ (instancetype)sharedInstance;


/**
 get请求

 @param url 请求地址
 @param params 请求参数
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)getRequestWithUrl:(NSString *)url
                   params:(id)params
                  success:(void (^)(id  responseObject))success
                  failure:(void (^)(NSError *  error))failure;


/**
 Post请求

 @param url 请求地址
 @param params 请求参数
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)postRequestWithUrl:(NSString *)url
                    params:(id)params
                   success:(void (^)(id  responseObject))success
                   failure:(void (^)(NSError *  error))failure;

/**
 Post请求
 
 @param url 请求全路径地址
 @param params 请求参数
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)postRequestWithFullUrl:(NSString *)url
                        params:(id)params
                       success:(void (^)(id  responseObject))success
                       failure:(void (^)(NSError *  error))failure;




+ (void)postMultipartWithUrl:(NSString *)urlStr
                      params:(NSDictionary *)params
                    fileData:(NSData *)fileData
                     success:(void (^)(id responseObject))success
                        fail:(void (^)())fail;

/**
 *文件上传,自己定义文件名
 *urlStr:    需要上传的服务器url
 *fileData:   二进制文件
 *name:  The name to be associated with the specified data. This parameter must not be `nil`.
 *fileName:  文件在服务器上以什么名字保存
 *fileTye:   文件类型
 *
 */
+ (void)postUploadWithUrl:(NSString *)urlStr
                 fileData:(NSData *)fileData
                     name:(NSString *)name
                 fileName:(NSString *)fileName
                 fileType:(NSString *)fileTye
                 progress:(void (^)(double))progress
                  success:(void (^)(id responseObject))success
                     fail:(void (^)())fail;



/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的url
 */
+(void)cancelHttpRequestWithRequestType:(NSString *)requestType
                       requestUrlString:(NSString *)string;
/**
 *  取消所有的网络请求
 */
+(void)cancelAllRequest;


@end
