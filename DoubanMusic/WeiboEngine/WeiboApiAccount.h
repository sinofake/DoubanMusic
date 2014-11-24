
#ifndef WeiboDemo_WeiboApiAccount_h
#define WeiboDemo_WeiboApiAccount_h

//微博类型枚举值
typedef enum {
    SINA_WEIBO,//新浪
    TENCENT_WEIBO,//腾讯
    MAX_WEIBO
} WeiboType;

#define OAuthLoginSucceed @"OAuthLoginSucceed"

// 新浪weibo开发者账号
#define SINA_APP_KEY @"690825030"
#define SINA_APP_SECRET @"3abdb3a1870d431a3e25f43c9b75dee6"
#define SINA_CALLBACK @"http://www.1000phone.com"

//#define SINA_APP_KEY @"1562171504"
//#define SINA_APP_SECRET @"3ff6d3197c09124b179e17f59baf74e1"
//#define SINA_CALLBACK @"http://www.huse.cn/"

//新浪微博api地址
#define SINA_V2_DOMAIN             @"https://api.weibo.com/2"
#define SINA_V2_AUTHORIZE          @"https://api.weibo.com/oauth2/authorize"
#define SINA_V2_ACCESS_TOKEN       @"https://api.weibo.com/oauth2/access_token"

//参数名
#define SINA_USER_STORE_ACCESS_TOKEN     @"SinaAccessToken"
#define SINA_USER_STORE_EXPIRATION_DATE  @"SinaExpirationDate"
#define SINA_USER_STORE_USER_ID          @"SinaUserID"
#define SINA_USER_STORE_USER_NAME        @"SinaUserName"

// 腾讯weibo开发者账号
#define TENCENT_APP_KEY @"801124323"
#define TENCENT_APP_SECRET @"9d19ed0ae00ef963d73c06e518a34d27"
#define TENCENT_CALLBACK @"http://www.1000phone.com"

//腾讯微博api地址
#define TENCENT_V2_DOMAIN       @"https://open.t.qq.com/api"
#define TENCENT_V2_AUTHORIZE    @"https://open.t.qq.com/cgi-bin/oauth2/authorize"
#define TENCENT_V2_ACCESS_TOKEN @"https://open.t.qq.com/cgi-bin/oauth2/access_token"

//参数名
#define TENCENT_USER_STORE_ACCESS_TOKEN     @"TencentAccessToken"
#define TENCENT_USER_STORE_EXPIRATION_DATE  @"TencentExpirationDate"
#define TENCENT_USER_STORE_USER_ID          @"TencentUserID"
#define TENCENT_USER_STORE_USER_NAME        @"TencentUserName"
#define TENCENT_USER_STORE_OPENID           @"TencentOpenID"
#define TENCENT_USER_STORE_OPENKEY          @"TencentOpenKey"
#define TENCENT_USER_STORE_OAUTH2           @"TencentOAuth2Str"

#endif
