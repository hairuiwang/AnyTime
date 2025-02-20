//
//  AnyTimeHomeModel.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AnyTimeActingModel;
@class AnyTimeHmmModel;
@class AnyTimeForestModel;
@class AnyTimeKeepModel;
@interface AnyTimeHomeModel : NSObject

@property (nonatomic,assign) NSInteger chin;////强制定位字段：1强制，0不强制， 当等于1时候，点击申请需要判断是否有定位权限，没有的话不允许点击，提示去系统里设置
@property (nonatomic,assign) NSInteger motioned; //首页差异化模块显示状态，1表示显示，0表示不显示
@property (nonatomic,strong) AnyTimeActingModel * acting;//大卡位 或 小卡位   必有，重点
@property (nonatomic,strong) AnyTimeHmmModel * hmm;// 逾期提醒模块 (首页2才展示,可能有多条，做成轮播样式，首页1不展示，但是测试时候首页1也会返回数据)
@property (nonatomic,strong) AnyTimeForestModel * forest;
//banner，取下发的，不要写死，没有banner则不用管
@property (nonatomic,strong) AnyTimeKeepModel * keep;////产品列表模块（也叫极速列表）,可能有多条，首页2才有（测试时候首页1可能也会有）需要用白名单走完申贷流程

@end

@class AnyTimeActMurderousModel;
@interface AnyTimeActingModel : NSObject

@property (nonatomic,copy) NSString * aura;
@property (nonatomic,strong) NSArray<AnyTimeActMurderousModel *>* murderous;

@end

@interface AnyTimeActMurderousModel : NSObject

@property (nonatomic, strong) NSString *blood;
@property (nonatomic, strong) NSString *disgust;
@property (nonatomic, strong) NSString *figured;
@property (nonatomic, assign) NSString * funny;
@property (nonatomic, strong) NSString *killed;
@property (nonatomic, strong) NSString *loanRateImg;
@property (nonatomic, strong) NSString *loanRateUnit;
@property (nonatomic, strong) NSString *pretending;
@property (nonatomic, strong) NSString *punk;
@property (nonatomic, strong) NSString *scent;
@property (nonatomic, strong) NSString *similar;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *spar;
@property (nonatomic, strong) NSString *termInfoImg;

@end

@class AnyTimeHmmMurderousModel;
@interface AnyTimeHmmModel : NSObject

@property (nonatomic,copy) NSString * aura;
@property (nonatomic,strong) NSArray<AnyTimeHmmMurderousModel *>* murderous;

@end

@interface AnyTimeHmmMurderousModel : NSObject

@property (nonatomic, strong) NSString *disgusting;
@property (nonatomic, strong) NSString *few;
@property (nonatomic, strong) NSString *handed;
@property (nonatomic, strong) NSString *instantly;
@property (nonatomic, strong) NSString *possible;
@property (nonatomic, strong) NSString *repay_amount;
@property (nonatomic, strong) NSString *repay_btn_text;

@end

@class AnyTimeForestMurderousModel;
@interface AnyTimeForestModel : NSObject

@property (nonatomic,copy) NSString * aura;
@property (nonatomic,strong) NSArray<AnyTimeForestMurderousModel *>* murderous;

@end

@interface AnyTimeForestMurderousModel : NSObject

@property (nonatomic, strong) NSString *box;
@property (nonatomic, strong) NSString *disgusting;
@property (nonatomic, strong) NSString *handed;
@property (nonatomic, strong) NSString *product_url;
@property (nonatomic, strong) NSString *violent;
@property (nonatomic, assign) NSInteger window;

@end

@class AnyTimeKeepMurderousModel;
@interface AnyTimeKeepModel : NSObject

@property (nonatomic,copy) NSString * aura;
@property (nonatomic,strong) NSArray<AnyTimeKeepMurderousModel *>* murderous;


@end

@interface AnyTimeKeepMurderousModel : NSObject

@property (nonatomic, assign) NSInteger ahem;
@property (nonatomic, copy) NSString *blood;
@property (nonatomic, copy) NSString *buttonExplain;
@property (nonatomic, copy) NSString *disgust;
@property (nonatomic, copy) NSString *disgusting;
@property (nonatomic, assign) NSInteger enjoy;
@property (nonatomic, copy) NSString *falling;
@property (nonatomic, strong) NSArray *fell;
@property (nonatomic, assign) NSString * funny;
@property (nonatomic, assign) NSInteger god;
@property (nonatomic, assign) NSInteger grace;
@property (nonatomic, copy) NSString *hearing;
@property (nonatomic, copy) NSString *hurry;
@property (nonatomic, assign) BOOL isCopyPhone;
@property (nonatomic, copy) NSString *killed;
@property (nonatomic, copy) NSString *past;
@property (nonatomic, copy) NSString *pretending;
@property (nonatomic, assign) NSInteger rejected;
@property (nonatomic, copy) NSString *scent;
@property (nonatomic, assign) NSInteger seeing;
@property (nonatomic, copy) NSString *seem;
@property (nonatomic, copy) NSString *similar;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *spar;
@property (nonatomic, strong) NSArray *studied;
@property (nonatomic, copy) NSString *supposedly;
@property (nonatomic, copy) NSString *talking;
@property (nonatomic, copy) NSString *telling;
@property (nonatomic, copy) NSString *these;
@property (nonatomic, assign) NSInteger todayApplyNum;

@end

NS_ASSUME_NONNULL_END
