//
//  AnyTimeOrderModel.h
//  AnyTime
//
//  Created by Tingyu on 2025/1/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AnyTimeOrderBlowModel;
@interface AnyTimeOrderModel : NSObject

@property (nonatomic,strong) NSArray<AnyTimeOrderBlowModel *> *blow;
@property (nonatomic,strong) NSString * puppy;

@end

@class AnyTimeOrderBlowGoldenModel;
@interface AnyTimeOrderBlowModel : NSObject

@property (nonatomic,strong) NSString * reserved;// 订单ID
@property (nonatomic,strong) AnyTimeOrderBlowGoldenModel *  golden;

@end

@interface AnyTimeOrderBlowGoldenModel : NSObject

// 订单ID
@property (nonatomic, copy) NSString *reserved;
// 产品ID
@property (nonatomic, assign) NSInteger gate;
// logo链接
@property (nonatomic, copy) NSString *blood;
// 产品名
@property (nonatomic, copy) NSString *pretending;
// 订单状态
@property (nonatomic, copy) NSString *puzzle;
// 右上角订单状态文案
@property (nonatomic, copy) NSString *through;
// 金额描述
@property (nonatomic, copy) NSString *passing;
// 金额
@property (nonatomic, copy) NSString *easily;
// 日期文案
@property (nonatomic, copy) NSString *nagging;
// 日期
@property (nonatomic, copy) NSString *injury;
// 按钮文案，返回空时说明不用展示按钮
@property (nonatomic, copy) NSString *first;
// 订单描述文案
@property (nonatomic, copy) NSString *touched;
// 类型（1:逾期, 2:还款中, 3:未申请, 4:审核中, 5:已完成）
@property (nonatomic, assign) NSInteger now;
// 点击跳转的 URL（H5 或原生地址）
@property (nonatomic, copy) NSString *sour;

@end

NS_ASSUME_NONNULL_END
