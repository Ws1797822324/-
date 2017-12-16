//
//  LXFHouseLoanCalculator.h
//
//  Created by LinXunFeng on 2017/8/25.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import <Foundation/Foundation.h>
@class LXFHouseLoanCalcModel, LXFHouseLoanResultModel;

@interface LXFHouseLoanCalculator : NSObject

/** =================================== 商业贷款 =================================== */

#pragma mark 按商业贷款等额本息总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateBusinessLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:(LXFHouseLoanCalcModel *)calcModel;
#pragma mark 按商业贷款等额本金总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateBusinessLoanAsTotalPriceAndEqualPrincipalWithCalcModel:(LXFHouseLoanCalcModel *)calcModel;


/** =================================== 公积金贷款 =================================== */

#pragma mark 按公积金贷款等额本息总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateFundLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:(LXFHouseLoanCalcModel *)calcModel;
#pragma mark 按公积金贷款等额本金总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateFundLoanAsTotalPriceAndEqualPrincipalWithCalcModel:(LXFHouseLoanCalcModel *)calcModel;


/** =================================== 组合型贷款 =================================== */
#pragma mark 按组合型贷款等额本息总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateCombinedLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:(LXFHouseLoanCalcModel *)calcModel;
#pragma mark 按组合型贷款等额本金总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateCombinedLoanAsTotalPriceAndEqualPrincipalWithCalcModel:(LXFHouseLoanCalcModel *)calcModel;

@end

@interface LXFHouseLoanCalcModel : NSObject

/** 单价 */
@property (nonatomic, assign) double unitPrice;
/** 面积 */
@property (nonatomic, assign) double area;
/** 商业贷款总额 */
@property (nonatomic, assign) double businessTotalPrice;
/** 公积金贷款总额 */
@property (nonatomic, assign) double fundTotalPrice;
/** 按揭年数 */
@property (nonatomic, assign) int mortgageYear;
/** 按揭成数 */
@property (nonatomic, assign) int mortgageMulti;
/** 银行利率 */
@property (nonatomic, assign) double bankRate;
/** 公积金利率 */
@property (nonatomic, assign) double fundRate;

@end


@interface LXFHouseLoanResultModel : NSObject
// 房屋总价
@property (nonatomic, assign) double houseTotalPrice;
/** 贷款总额 */
@property (nonatomic, assign) double loanTotalPrice;
/** 还款总额 */
@property (nonatomic, assign) double repayTotalPrice;
/** 支付利息 */
@property (nonatomic, assign) double interestPayment;
/** 按揭年数 */
@property (nonatomic, assign) double mortgageYear;
/** 按揭月数 */
@property (nonatomic, assign) double mortgageMonth;
/** 月均还款 */
@property (nonatomic, assign) double avgMonthRepayment;
/** 首月还款 */
@property (nonatomic, assign) double firstMonthRepayment;
/** 每月还款数组 */
@property (nonatomic, strong) NSMutableArray *monthRepaymentArr;

/** 每月递减 */ 
@property (nonatomic ,assign) double decrease;

/** 等额本息 月供本金 Arr  */
@property (nonatomic ,strong) NSMutableArray *ygbjArr;

@property (nonatomic ,strong) NSMutableArray *lixiArr;

@property (nonatomic ,strong) NSMutableArray *remainderArr;



@end


