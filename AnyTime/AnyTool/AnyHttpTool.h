//
//  AnyHttpTool.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyHttpTool : NSObject

/// 获取验证码
/// - Parameters:
///   - turning: 手机号
///   - direction:混淆
///   - success: 成功
///   - failure: 失败
+ (void)requestCodeWithTurning:(NSString *)turning
                      direction:(NSString *)direction
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

/// 登录
/// - Parameters:
///   - boy: 手机号
///   - talk: 验证码
///   - events: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)loginWithBoy:(NSString *)boy
               talk:(NSString *)talk
             events:(NSString *)events
            success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure;

/// 退出登录
/// - Parameters:
///   - showered: 混淆
///   - assassins: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)logoutWithShowered:(NSString *)showered
                 assassins:(NSString *)assassins
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

/// 账户注销
/// - Parameters:
///   - gotten: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)deactivateAccountWithGotten:(NSString *)gotten
                             success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;


/// APP首页
/// - Parameters:
///   - auras: 混淆
///   - apart: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)fetchHomePageWithAuras:(NSString *)auras
                         apart:(NSString *)apart
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

/// 个人中心
/// - Parameters:
///   - sat: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)fetchProfileWithSat:(NSString *)sat
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;


/// 产品申请
/// - Parameters:
///   - box: 产品Id
///   - magic: 混淆
///   - following: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)fetchProductDetailWithBox:(NSString *)box
                            magic:(NSString *)magic
                        following:(NSString *)following
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

/// 产品详情
/// - Parameters:
///   - box: 产品Id
///   - depending: 混淆
///   - group: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)fetchProductDetailWithBox:(NSString *)box
                         depending:(NSString *)depending
                             group:(NSString *)group
                           success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;


/// 获取用户身份信息（第一项）
/// - Parameters:
///   - box: 产品Id
///   - ten: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)fetchUserIdentityWithBox:(NSString *)box
                              ten:(NSString *)ten
                          success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

/// 上传(face,身份证正面)（第一项）
/// - Parameters:
///   - towers: 图片来源:1相册 2:拍照上传
///   - box: 产品id
///   - aura: 10:人脸自拍, 11身份证正面
///   - casually: 压缩500K以内的图片NSData 参考代码：[formData appendPartWithFileData:data name:key fileName:@"xx.jpg" mimeType:@"image/jpeg"];
///   - top: 卡类型 UMID/SSS/TIN/PASSPORT/DRIVINGLICENSE/PRC/POSTAL/Voter/PhilHealth
///   - weird: 默认为空
///   - direction: 混淆
///   - tower: 传1即可
///   - success: 成功
///   - failure: 失败
+ (void)uploadFaceIDImageWithTowers:(NSString *)towers
                               box:(NSString *)box
                             aura:(NSString *)aura
                           casually:(UIImage *)casually  // 图片数据
                               top:(NSString *)top
                            weird:(NSString *)weird
                        direction:(NSString *)direction
                            tower:(NSString *)tower
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

/// 保存用户身份证信息（第一项）
/// - Parameters:
///   - ruins:  出生日期 日-月-年
///   - people: 证件号码
///   - groove: 姓名
///   - aura:  固定
///   - top: 卡类型 UMID/SSS/TIN/PASSPORT/DRIVINGLICENSE/PRC/POSTAL/Voter/PhilHealth
///   - flinched: 混淆字段
///   - success: 成功
///   - failure: 失败
+ (void)saveUserIdentityWithRuins:(NSString *)ruins
                            people:(NSString *)people
                           groove:(NSString *)groove
                             aura:(NSString *)aura
                              top:(NSString *)top
                         flinched:(NSString *)flinched
                           success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

/// 保存用户信息（第二项）
/// - Parameters:
///   - box: 产品ID
///   - keeping: 混淆字段
///   - helpful: 教育
///   - broke: 家庭住址
///   - war: 家庭城市
///   - estate: 家庭电话
///   - destroy: 居住
///   - growing: 婚姻
///   - hoping: 用途
///   - strength: 性别
///   - success: 成功
///   - failure: 失败
+ (void)saveUserInfoWithBox:(NSString *)box
                    keeping:(NSString *)keeping
                    helpful:(NSString *)helpful
                      broke:(NSString *)broke
                        war:(NSString *)war
                     estate:(NSString *)estate
                    destroy:(NSString *)destroy
                    growing:(NSString *)growing
                     hoping:(NSString *)hoping
                   strength:(NSString *)strength
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;


/// 获取工作信息（第三项）
/// - Parameters:
///   - box: 产品Id
///   - success: 成功
///   - failure: 失败
+ (void)fetchWorkInfoWithBox:(NSString *)box
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;


/// 保存工作信息（第三项）
/// - Parameters:
///   - box: 产品Id
///   - lair: 公司详细地址
///   - create: 公司名称
///   - marquis: 公司电话
///   - stay: 行业
///   - expecting: 工作类型
///   - way: 支付日
///   - overwhelming: 月薪
///   - humans: 工作城市
///   - hated: 工作年限
///   - though: 混淆
///   - describe: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)saveWorkInfoWithBox:(NSString *)box
                       lair:(NSString *)lair
                     create:(NSString *)create
                    marquis:(NSString *)marquis
                       stay:(NSString *)stay
                  expecting:(NSString *)expecting
                        way:(NSString *)way
                overwhelming:(NSString *)overwhelming
                       humans:(NSString *)humans
                        hated:(NSString *)hated
                       though:(NSString *)though
                    describe:(NSString *)describe
                     success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;


/// 获取联系人信息
/// - Parameters:
///   - box: 产品Id
///   - saying: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)fetchContactInfoWithBox:(NSString *)box
                          saying:(NSString *)saying
                         success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

/// 保存联系人信息
/// - Parameters:
///   - box: 产品Id
///   - gone: json字符串数据
///   - success: 成功
///   - failure: 失败
+ (void)saveContactInfoWithBox:(NSString *)box
                          gone:(NSString *)gone
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

/// 获取绑卡信息（第五项）
/// - Parameters:
///   - hasn: 是否添加新卡（app认证项给0，h5添加新卡给1
///   - kid: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)fetchBindCardInfoWithHasn:(NSString *)hasn
                               kid:(NSString *)kid
                           success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

/// 提交绑卡（第五项）
/// - Parameters:
///   - box: 产品Id
///   - top: 1.ewallet 2 bank, 这个key(cardType)需要开发手动添加，不是下发的
///   - isn: 081777277
///   - food:  选中的ewallet/bank的type（ewallet是字符串，bank是数字），从上个接口搜“卡类型”关键字
///   - drop: 081777277
///   - morning: firstName
///   - early: middleName
///   - distance: lastName
///   - far: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)submitBindCardInfoWithBox:(NSString *)box
                              top:(NSString *)top
                             isn:(NSString *)isn
                            food:(NSString *)food
                            drop:(NSString *)drop
                          morning:(NSString *)morning
                            early:(NSString *)early
                         distance:(NSString *)distance
                              far:(NSString *)far
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;


/// 地址初始化 -- 固定是三级
/// - Parameters:
///   - success: 成功
///   - failure: 失败
+ (void)initializeAddressInfoWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/// 用户银行卡列表
/// - Parameters:
///   - success: 成功
///   - failure: 失败
+ (void)fetchBankCardListWithSuccess:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

/// 更换银行卡
/// - Parameters:
///   - dragon: 绑卡id
///   - western: 订单号 （订单列表、订单详情等页面需要给，个人中心这种拿不到的不用给）
///   - success: 成功
///   - failure: 失败
+ (void)updateBankCardWithDragon:(NSString *)dragon
                         western:(NSString *)western
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

/// 根据订单号获取跳转地址
/// - Parameters:
///   - western: 订单号
///   - inn: 混淆
///   - lead: 混淆
///   - followed: 混淆
///   - carriage: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)getRedirectURLWithWestern:(NSString *)western
                              inn:(NSString *)inn
                            lead:(NSString *)lead
                         followed:(NSString *)followed
                         carriage:(NSString *)carriage
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;


/// 订单列表
/// - Parameters:
///   - turtle: 状态 4全部 7进行中 6待还款 5已结清
///   - success: 成功
///   - failure: 失败
+ (void)getOrderListWithTurtle:(NSString *)turtle
                        success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;


/// 上报位置信息
/// - Parameters:
///   - fearless: 省
///   - hands: 国家code
///   - cup: 国家
///   - empty: 街道
///   - earlier: 市
///   - looked: 纬度
///   - thanks: 经度
///   - days: 混淆
///   - four: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)reportLocationWithFearless:(NSString *)fearless
                             hands:(NSString *)hands
                               cup:(NSString *)cup
                             empty:(NSString *)empty
                           earlier:(NSString *)earlier
                            looked:(NSString *)looked
                            thanks:(NSString *)thanks
                              days:(NSString *)days
                               four:(NSString *)four
                            success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

/// google_market上报
/// - Parameters:
///   - met: 混淆
///   - each: idfv
///   - closer: idfa
///   - success: 成功
///   - failure: 失败
+ (void)reportGoogleMarketWithMet:(NSString *)met
                             each:(NSString *)each
                          closer:(NSString *)closer
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;


/// 上报风控埋点
/// - Parameters:
///   - gate: 产品Id
///   - commanded: 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
///   - agreed: 全局订单号，不用管
///   - behind: idfv
///   - hear: idfa
///   - thanks: 经度
///   - looked: 纬度
///   - allowance: 开始时间
///   - large: 结束时间
///   - father: 混淆
///   - success: 成功
///   - failure: 失败
+ (void)reportRiskControlWithGate:(NSString *)gate
                        commanded:(NSString *)commanded
                          agreed:(NSString *)agreed
                          behind:(NSString *)behind
                            hear:(NSString *)hear
                          thanks:(NSString *)thanks
                          looked:(NSString *)looked
                       allowance:(NSString *)allowance
                            large:(NSString *)large
                           father:(NSString *)father
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;


/// 设备信息上报详细信息 [上报数据需要加密]
/// - Parameters:
///   - gone: json字符串（用base64加密）
///   - success: 成功
///   - failure: 失败
+ (void)reportDeviceInfoWithGone:(NSString *)gone
                          success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;


/// 上报通讯录
/// - Parameters:
///   - aura: 类型 3=通讯录 此版本固定传3即可
///   - statue: 混淆
///   - standing: 混淆
///   - gone: json字符串（用base64加密）
///   - success: 成功
///   - failure: 失败
+ (void)reportContactsWithAura:(NSString *)aura
                        statue:(NSString *)statue
                      standing:(NSString *)standing
                          gone:(NSString *)gone
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

/// 上报Apple推送token
/// - Parameters:
///   - contact: contact description
///   - success: 成功
///   - failure: 失败
+ (void)reportApplePushTokenWithContact:(NSString *)contact
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
