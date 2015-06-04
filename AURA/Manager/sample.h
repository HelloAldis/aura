//
//  sample.h
//  AURA
//
//  Created by MacMiniS on 15-3-18.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#ifndef AURA_sample_h
#define AURA_sample_h
/*
 
 015-04-08 21:18:31.943 AURA[9094:2049461] POST 'http://182.92.166.245/aura/login': {
 "Accept-Language" = "en;q=1, zh-Hans;q=0.9";
 "Content-Type" = "application/json";
 "User-Agent" = "AURA/1.1 (iPod touch; iOS 8.1; Scale/2.00)";
 deviceId = "FF421401-A33F-44CA-A0B3-7D3C2236063F";
 } {"username":"a","type":"email","password":"a"}
 2015-04-08 21:18:32.192 AURA[9094:2049461] 200 'http://182.92.166.245/aura/login' [0.2495 s]: {
 Connection = "keep-alive";
 "Content-Length" = 78;
 "Content-Type" = "application/json";
 Date = "Wed, 08 Apr 2015 13:18:33 GMT";
 Server = "nginx/1.2.9";
 } {"token":"000000557c0c4a2192278f5f5f6550bf","userid":"85","result_code":10000}
 
 2015-04-16 22:17:33.358 AURA[2364:408412] 200 'http://182.92.166.245/aura/queryMostPopPhoto' [0.2817 s]: {
 Connection = "keep-alive";
 "Content-Length" = 1411;
 "Content-Type" = "application/json";
 Date = "Thu, 16 Apr 2015 14:17:34 GMT";
 Server = "nginx/1.2.9";
 } {"result_code":10000,"photoes":[{"albuminfo":{"onlyfindbyfriend":"0","type":"private","name":"test1414468600","mtime":"2014-10-28 11:56:44"},"sha1":"3165fc54b68ca05caeffa60c8b5118eb5b7c44b2","photoid":"1","ctime":"2014-10-28 11:56:57","city":"\u5317\u4eac\u5e02","cityid":"1","albumid":"52","fcount":"10"},{"albuminfo":{"onlyfindbyfriend":"0","type":"private","name":"test21422955059","mtime":"2015-02-03 17:17:40"},"sha1":"3e9c7f5988e5e6f6daf216e96df08c8b92fa15f0","photoid":"44","ctime":"2015-02-03 17:17:40","city":"\u5317\u4eac\u5e02","cityid":"1","albumid":"120","fcount":"1"},{"albuminfo":{"onlyfindbyfriend":"0","type":"private","name":"test21422955013","mtime":"2015-02-03 17:16:54"},"sha1":"3e9c7f5988e5e6f6daf216e96df08c8b92fa15f0","photoid":"43","ctime":"2015-02-03 17:16:55","city":"\u5317\u4eac\u5e02","cityid":"1","albumid":"119","fcount":"1"},{"albuminfo":{"onlyfindbyfriend":"0","type":"private","name":"test21422954787","mtime":"2015-02-03 17:13:08"},"sha1":"3e9c7f5988e5e6f6daf216e96df08c8b92fa15f0","photoid":"42","ctime":"2015-02-03 17:13:08","city":"\u5317\u4eac\u5e02","cityid":"1","albumid":"118","fcount":"1"},{"albuminfo":{"onlyfindbyfriend":"0","type":"private","name":"test21428151041","mtime":"2015-04-04 20:37:43"},"sha1":"3e9c7f5988e5e6f6daf216e96df08c8b92fa15f0","photoid":"73","ctime":"2015-04-04 20:37:47","city":"\u5317\u4eac\u5e02","cityid":"1","albumid":"151","fcount":"1"}]}
 
 2015-03-18 16:48:05.152 AURA[2063:376258] POST 'http://182.92.166.245/aura/createAlbum': {
 "Accept-Language" = "en;q=1, zh-Hans;q=0.9";
 "Content-Type" = "application/json; charset=utf-8";
 "User-Agent" = "AURA/1 (iPod touch; iOS 8.1; Scale/2.00)";
 deviceId = "FF421401-A33F-44CA-A0B3-7D3C2236063F";
 } {"name":"哈哈","longitude":114.4009406311924,"latitude":30.47619371544699,"token":"0000005547004ab0a26f4d78a421aba0"}
 2015-03-18 16:48:08.391 AURA[2063:376258] 200 'http://182.92.166.245/aura/createAlbum' [3.2389 s]: {
 Connection = "keep-alive";
 "Content-Length" = 35;
 "Content-Type" = "application/json";
 Date = "Wed, 18 Mar 2015 08:48:08 GMT";
 Server = "nginx/1.2.9";
 } {"albumid":137,"result_code":10000}
 
 
 2015-03-18 16:48:09.031 AURA[2063:376258] PUT 'http://aura.oss.aliyuncs.com/f65442450787ad44a846f0e8dbc515cd19c03f08?OSSAccessKeyId=8qyE85QH1EBRiV23&Expires=1426704489&Signature=AxpqCDiRIguOjSRXz%2BytVMIUOaI%3D': {
 "Accept-Language" = "en;q=1, zh-Hans;q=0.9";
 "User-Agent" = "AURA/1 (iPod touch; iOS 8.1; Scale/2.00)";
 } (null)
 2015-03-18 16:48:38.829 AURA[2063:376258] 200 'http://aura.oss.aliyuncs.com/f65442450787ad44a846f0e8dbc515cd19c03f08?OSSAccessKeyId=8qyE85QH1EBRiV23&Expires=1426704489&Signature=AxpqCDiRIguOjSRXz%2BytVMIUOaI%3D' [29.7977 s]: {
 Connection = close;
 "Content-Length" = 0;
 Date = "Wed, 18 Mar 2015 08:48:40 GMT";
 Etag = "\"08E72B5668D4B9B5DA8DF6C5F1A3A1AE\"";
 Server = AliyunOSS;
 "x-oss-request-id" = 55093BCC010B7A0F14E47BBA;
 }
 
 2015-03-18 21:18:28.643 AURA[2173:401256] POST 'http://182.92.166.245/aura/commit': {
 "Accept-Language" = "en;q=1, zh-Hans;q=0.9";
 "Content-Type" = "application/json";
 "User-Agent" = "AURA/1.0 (iPod touch; iOS 8.1; Scale/2.00)";
 deviceId = "FF421401-A33F-44CA-A0B3-7D3C2236063F";
 } {"sha1":"3da3ab9f6a0a08e7efe7536316a850bdca8e4a2b","albumid":138,"longitude":114.3936637048804,"latitude":30.46520258545812,"token":"0000005547004ab0a26f4d78a421aba0"}
 2015-03-18 21:18:33.979 AURA[2173:401256] 200 'http://182.92.166.245/aura/commit' [5.3357 s]: {
 Connection = "keep-alive";
 "Content-Length" = 34;
 "Content-Type" = "application/json";
 Date = "Wed, 18 Mar 2015 13:18:30 GMT";
 Server = "nginx/1.2.9";
 } {"photoid":61,"result_code":10000}
 
 2015-04-16 22:19:11.273 AURA[2364:408412] POST 'http://182.92.166.245/aura/queryPhotoInfoByCtime': {
 "Accept-Language" = "en;q=1, zh-Hans;q=0.9";
 "Content-Type" = "application/json";
 "User-Agent" = "AURA/1.1 (iPod touch; iOS 8.3; Scale/2.00)";
 deviceId = "99C7AC63-0024-43A5-98B2-5C78F8A9F0DC";
 } {"cursor":"1","albumid":"108","size":1000,"token":"00000055ed5949d99e1f5417c634660e"}
 2015-04-16 22:19:11.362 AURA[2364:408412] 200 'http://182.92.166.245/aura/queryPhotoInfoByCtime' [0.0889 s]: {
 Connection = "keep-alive";
 "Content-Length" = 486;
 "Content-Type" = "application/json";
 Date = "Thu, 16 Apr 2015 14:19:12 GMT";
 Server = "nginx/1.2.9";
 } {"result_code":10000,"photoes":[{"city":"\u6b66\u6c49\u5e02","sha1":"2ee7d2d34f4f7c01eebac62981336b3e0f27de57","photoid":"34","ctime":"2014-11-15 22:43:35","cityid":"2","fcount":"0"},{"city":"\u6b66\u6c49\u5e02","sha1":"2ee7d2d34f4f7c01eebac62981336b3e0f27de57","photoid":"35","ctime":"2014-11-15 22:46:18","cityid":"2","fcount":"0"},{"city":"\u6b66\u6c49\u5e02","sha1":"2ee7d2d34f4f7c01eebac62981336b3e0f27de57","photoid":"36","ctime":"2014-11-15 22:51:04","cityid":"2","fcount":"0"}]}
 
 2015-04-16 22:19:39.001 AURA[2364:408412] 200 'http://182.92.166.245/aura/queryPhotoInfoByFcount' [0.0892 s]: {
 Connection = "keep-alive";
 "Content-Length" = 486;
 "Content-Type" = "application/json";
 Date = "Thu, 16 Apr 2015 14:19:40 GMT";
 Server = "nginx/1.2.9";
 } {"result_code":10000,"photoes":[{"city":"\u6b66\u6c49\u5e02","sha1":"2ee7d2d34f4f7c01eebac62981336b3e0f27de57","photoid":"34","ctime":"2014-11-15 22:43:35","cityid":"2","fcount":"0"},{"city":"\u6b66\u6c49\u5e02","sha1":"2ee7d2d34f4f7c01eebac62981336b3e0f27de57","photoid":"35","ctime":"2014-11-15 22:46:18","cityid":"2","fcount":"0"},{"city":"\u6b66\u6c49\u5e02","sha1":"2ee7d2d34f4f7c01eebac62981336b3e0f27de57","photoid":"36","ctime":"2014-11-15 22:51:04","cityid":"2","fcount":"0"}]}
 
 2015-04-16 22:18:18.671 AURA[2364:408412] 200 'http://182.92.166.245/aura/queryRecentlyInfo' [0.0821 s]: {
 Connection = "keep-alive";
 "Content-Length" = 309;
 "Content-Type" = "application/json";
 Date = "Thu, 16 Apr 2015 14:18:20 GMT";
 Server = "nginx/1.2.9";
 } {"result_code":10000,"photoes":[{"albuminfo":{"onlyfindbyfriend":"0","type":"private","name":"a","mtime":"2014-11-14 22:49:50"},"sha1":"2ee7d2d34f4f7c01eebac62981336b3e0f27de57","photoid":"34","ctime":"2014-11-15 22:43:35","city":"\u6b66\u6c49\u5e02","userid":"85","cityid":"2","albumid":"108","fcount":"0"}]}
 
 
 2015-04-16 22:22:44.829 AURA[2364:408412] POST 'http://182.92.166.245/aura/recommendAlbum': {
 "Accept-Language" = "en;q=1, zh-Hans;q=0.9";
 "Content-Type" = "application/json";
 "User-Agent" = "AURA/1.1 (iPod touch; iOS 8.3; Scale/2.00)";
 deviceId = "99C7AC63-0024-43A5-98B2-5C78F8A9F0DC";
 } {"token":"00000055ed5949d99e1f5417c634660e","latitude":30.46285379173282,"longitude":114.3947986809042}
 2015-04-16 22:22:44.917 AURA[2364:408412] 200 'http://182.92.166.245/aura/recommendAlbum' [0.0874 s]: {
 Connection = "keep-alive";
 "Content-Length" = 225;
 "Content-Type" = "application/json";
 Date = "Thu, 16 Apr 2015 14:22:46 GMT";
 Server = "nginx/1.2.9";
 } {"result_code":10000,"photoes":[{"city":"\u6b66\u6c49\u5e02","sha1":"434ae16409032e1f9caabd02a6a34725c9278a5a","onlyfindbyfriend":"0","userid":"85","cityid":"2","albumid":"211","fcount":"0","photoid":"111","type":"tourism"}]}
 
 */
#endif
