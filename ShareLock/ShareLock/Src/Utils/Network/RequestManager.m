//
//  RequestManager.m
//  HXBaseProjectDemo
//
//  Created by 陈区 on 2017/1/16.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "RequestManager.h"
#import <AFNetworking/AFNetworking.h>
#import "SystemAccountManager.h"

@interface RequestManager ()

@property (nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation RequestManager

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

#pragma mark - 配置请求底层参数

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        //主Url 可以封装起来统一管理,也可以直接写在GET参数里单独管理
        NSURL *baseUrl = [NSURL URLWithString:kSystemConfigModel.networkConfig.baseURL];
        
        //设置最大连接数
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPMaximumConnectionsPerHost = kSystemConfigModel.maxOperationCount;
        
        //AFHTTPSessionManager 创建一个网络请求
        _sessionManager = [[AFHTTPSessionManager manager]initWithBaseURL:baseUrl sessionConfiguration:sessionConfiguration];
                          
        //请求超时时间
        _sessionManager.requestSerializer.timeoutInterval = kSystemConfigModel.timeoutInterval;
        
        //请求格式
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];

        //响应格式
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"application/x-www-form-urlencoded", @"text/plain", @"text/xml", nil];
        
    }
    

    return _sessionManager;
}



#pragma mark - 各种请求

//GET
- (void)getRequestWithUrl:(NSString *)url params:(id)params success:(void (^)(id  _Nullable responseObject))success failure:(void (^)(NSError *  error))failure {
    
    if ([kNetworkType isEqualToString:kNoNetwork]) {
        failure(nil);
        return;
    }
    
    NSMutableDictionary *dic  = [NSMutableDictionary dictionaryWithDictionary:params];
    if (kBaseRequestModel.token) {
        dic[@"token"] = kBaseRequestModel.token;
    }
    if (kBaseRequestModel.usr_id) {
        dic[@"usr_id"] = kBaseRequestModel.usr_id;
    }
    

    [self.sessionManager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {

        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DDLogVerbose(@"%@/%@?%@:%@",kSystemConfigModel.networkConfig.baseURL,url,dic,responseObject);

        if (success) {
            success(responseObject);
            if ([responseObject[@"ret"] intValue] == 103) {
                [[BusinessManager sharedManager].systemAccountManager requesLogOut:^(NSDictionary *dict) {
                    
                } failure:^{
                    
                }];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogError(@"%@/%@?%@:%@",kSystemConfigModel.networkConfig.baseURL,url,dic,error);
        if (failure) {
            failure(error);
            [ProgressHUD showHudTipError:error];
        }
    }];
}


//POST
- (void)postRequestWithUrl:(NSString *)url params:(id)params success:(void (^)(id  _Nullable responseObject))success failure:(void (^)(NSError *  error))failure {
    
    if ([kNetworkType isEqualToString:kNoNetwork]) {
        failure(nil);
        return;
    }
    
    NSMutableDictionary *dic  = [NSMutableDictionary dictionaryWithDictionary:params];
    if (kBaseRequestModel.token) {
        if (!dic) {
            dic = [NSMutableDictionary dictionary];
        }
        dic[@"token"] = kBaseRequestModel.token;
    }
    if (kBaseRequestModel.usr_id) {
        dic[@"usr_id"] = kBaseRequestModel.usr_id;
    }
    
    DDLogVerbose(@"httpHeaders=%@",_sessionManager.requestSerializer.HTTPRequestHeaders);

    [self.sessionManager POST:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DDLogVerbose(@"%@/%@?%@:%@",kSystemConfigModel.networkConfig.baseURL,url,dic,responseObject);
        if (success) {
            success(responseObject);
            if ([responseObject[@"ret"] intValue] == 103) {
                [[BusinessManager sharedManager].systemAccountManager requesLogOut:^(NSDictionary *dict) {
                    
                } failure:^{
                    
                }];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogError(@"%@/%@?%@:%@",kSystemConfigModel.networkConfig.baseURL,url,dic,error);
        if (failure) {
            failure(error);
            [ProgressHUD showHudTipError:error];
        }
    }];
    
}

//POST
- (void)postRequestWithFullUrl:(NSString *)url params:(id)params success:(void (^)(id  _Nullable responseObject))success failure:(void (^)(NSError *  error))failure {
    
    if ([kNetworkType isEqualToString:kNoNetwork]) {
        failure(nil);
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求超时时间
    manager.requestSerializer.timeoutInterval = kSystemConfigModel.timeoutInterval;
    
    // Requests 已json方式请求
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    //添加统一参数
    NSMutableDictionary *dic  = [NSMutableDictionary dictionaryWithDictionary:params];
    if (kBaseRequestModel.token) {
        if (!dic) {
            dic = [NSMutableDictionary dictionary];
        }
        dic[@"token"] = kBaseRequestModel.token;
    }
    if (kBaseRequestModel.usr_id) {
        dic[@"usr_id"] = kBaseRequestModel.usr_id;
    }
    
    DDLogVerbose(@"httpHeaders=%@",_sessionManager.requestSerializer.HTTPRequestHeaders);
    
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DDLogVerbose(@"%@?%@:%@",url,dic,responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogError(@"%@?%@:%@",url,dic,error);
        if (failure) {
            failure(error);
            [ProgressHUD showHudTipError:error];
        }
    }];
    
}

+ (void)postMultipartWithUrl:(NSString *)urlStr
                      params:(NSDictionary *)params
                    fileData:(NSData *)fileData
                     success:(void (^)(id responseObject))success
                        fail:(void (^)())fail
{
    
    if ([kNetworkType isEqualToString:kNoNetwork]) {
        fail();
        return;
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (kBaseRequestModel.token) {
            [formData appendPartWithFormData:[kBaseRequestModel.token dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
        }
        
        if (kBaseRequestModel.usr_id) {
            [formData appendPartWithFormData:[kBaseRequestModel.usr_id dataUsingEncoding:NSUTF8StringEncoding] name:@"usr_id"];
        }
        
        for (NSString *key in params) {
            [formData appendPartWithFormData:[params[key] dataUsingEncoding:NSUTF8StringEncoding] name:key];

        }
              
        if (fileData) {
            [formData appendPartWithFileData:fileData name:@"img" fileName:@"gauge.png" mimeType:@"image/png"];

        }

        

        
        
        
    } error:nil];
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          fail();
                          [ProgressHUD showHudTipError:error];
                      } else {
                          success(responseObject);
                          if ([responseObject[@"ret"] intValue] == 103) {
                              [[BusinessManager sharedManager].systemAccountManager requesLogOut:^(NSDictionary *dict) {
                                  
                              } failure:^{
                                  
                              }];
                          }
                          DDLogVerbose(@"%@?%@:%@",urlStr,params,responseObject);
//                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
    
    
    
}


+ (void)postUploadWithUrl:(NSString *)urlStr
                 fileData:(NSData *)fileData
                     name:(NSString *)name
                 fileName:(NSString *)fileName
                 fileType:(NSString *)fileTye
                 progress:(void (^)(double))progress
                  success:(void (^)(id responseObject))success
                     fail:(void (^)())fail
{
    
    if ([kNetworkType isEqualToString:kNoNetwork]) {
        fail();
        return;
    }
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:fileTye];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress((double)uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        DDLogVerbose(@"completedUnitCount:%f,totalUnitCount:%lld,uploadProgress:%f",(double)uploadProgress.completedUnitCount,uploadProgress.totalUnitCount,(double)uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DDLogVerbose(@"%@:%@",urlStr,responseObject);

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogError(@"%@:%@",urlStr,error);

        if (fail) {
            fail();
            [ProgressHUD showHudTipError:error];

        }
    }];
}


+(void)cancelAllRequest
{
    [kRequestManager.operationQueue cancelAllOperations];
}


+(void)cancelHttpRequestWithRequestType:(NSString *)requestType
                       requestUrlString:(NSString *)string
{
    NSError * error;
    
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    
    NSString * urlToPeCanced = [[[kRequestManager.requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    
    
    for (NSOperation * operation in kRequestManager.operationQueue.operations) {
        
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            
            //请求的url匹配
            
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                
                [operation cancel];
                
            }
        }
        
    }
}




@end
