//
//  LXFHouseLoanCalculator.m
//
//  Created by LinXunFeng on 2017/8/25.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#pragma mark - 宏定义
//根据版本控制是否打印log
#ifdef DEBUG
#define LXFLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define LXFLog( s, ... )
#endif

#import "LXFHouseLoanCalculator.h"

@implementation LXFHouseLoanCalculator

// 按揭成数要除以10 (即值的范围：0.0~1.0)
// 利率要除以100 (即值的范围：0.0~1.0)

/** =================================== 商业贷款 =================================== */
#pragma mark - 商业贷款
#pragma mark 按商业贷款等额本息总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateBusinessLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:(LXFHouseLoanCalcModel *)calcModel {
    LXFLog(@"按商业贷款等额本息总价计算(总价)");
    // 贷款总额
    double loanTotalPrice = calcModel.businessTotalPrice;
    // 贷款月数
    int loanMonthCount = calcModel.mortgageYear * 12;
    // 月利率
    double monthRate = calcModel.bankRate / 100.0 / 12.0;
    // 每月还款
    double avgMonthRepayment = loanTotalPrice * monthRate * powf (1 + monthRate, loanMonthCount)/(powf(1+monthRate, loanMonthCount)-1);
    // 还款总额
    double repayTotalPrice = avgMonthRepayment*loanMonthCount;
    // 支付利息
    double interestPayment = repayTotalPrice-loanTotalPrice;
    
    // 每月还款数组
    NSMutableArray *monthRepaymentArr = [[NSMutableArray alloc] init];
    // 月供本金 数组
    NSMutableArray *ygbjArr = [NSMutableArray array];

    //余额数组
    NSMutableArray*yu_eArr = [NSMutableArray array];
    for (int i = 0; i<loanMonthCount; i++) {
        [monthRepaymentArr addObject:[NSString stringWithFormat:@"%.2f", avgMonthRepayment]];

        // 月供本金
        float ygbj = loanTotalPrice * monthRate * powf( 1 + monthRate, i) / (powf( 1 + monthRate, loanMonthCount)-1);
        [ygbjArr addObject:kString(@"%.2f", ygbj)];
        [yu_eArr addObject:kString(@"%.2f", repayTotalPrice - ((i + 1) * avgMonthRepayment))];

    }


    LXFHouseLoanResultModel *resultModel = [LXFHouseLoanResultModel new];
    resultModel.loanTotalPrice           = loanTotalPrice;
    resultModel.repayTotalPrice          = repayTotalPrice;
    resultModel.interestPayment          = interestPayment;
    resultModel.mortgageYear             = calcModel.mortgageYear;
    resultModel.mortgageMonth            = loanMonthCount;
    resultModel.avgMonthRepayment        = avgMonthRepayment;
    resultModel.firstMonthRepayment      = [[monthRepaymentArr firstObject] doubleValue];
    resultModel.monthRepaymentArr        = monthRepaymentArr;
    resultModel.ygbjArr = ygbjArr;
    resultModel.remainderArr = yu_eArr;
    return resultModel;
}
#pragma mark 按商业贷款等额本金总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateBusinessLoanAsTotalPriceAndEqualPrincipalWithCalcModel:(LXFHouseLoanCalcModel *)calcModel {
    LXFLog(@"按商业贷款等额本金总价计算(总价)");
    // 每月还款数组
    NSMutableArray *monthRepaymentArr = [[NSMutableArray alloc] init];
    // 贷款总额
    double loanTotalPrice = calcModel.businessTotalPrice;
    // 月利率
    double monthRate = calcModel.bankRate / 100.0 / 12.0;
    // 贷款月数
    int loanMonthCount = calcModel.mortgageYear * 12;
    // 每月所还本金（每月还款）
    double avgMonthPrincipalRepayment = loanTotalPrice / loanMonthCount;
    // 还款总额
    double repayTotalPrice = 0;

    //余额数组
    NSMutableArray*yu_eArr = [NSMutableArray array];

    for (int i = 0; i<loanMonthCount; i++) {
        // 每月还款
        // 公式：每月还款 + (贷款总额-每月还款*i) * 月利率
        double monthRepayment = avgMonthPrincipalRepayment + (loanTotalPrice - avgMonthPrincipalRepayment * i) * monthRate;
        [monthRepaymentArr addObject:[NSString stringWithFormat:@"%.2f", monthRepayment]];
        repayTotalPrice += monthRepayment;
    }
    // 月供本金 数组
    NSMutableArray *ygbjArr = [NSMutableArray array];
    for (int i = 0; i<loanMonthCount; i++) {

        // 月供本金
        float ygbj = loanTotalPrice * monthRate * powf( 1 + monthRate, i) / (powf( 1 + monthRate, loanMonthCount)-1);
        [ygbjArr addObject:kString(@"%.2f", ygbj)];
        
        [yu_eArr addObject: kString(@"%.2f", repayTotalPrice - (i+1)  * [monthRepaymentArr[0] floatValue] + i  * (i +1)/2 *  ([monthRepaymentArr[0] floatValue] - [monthRepaymentArr[1] floatValue]))];


    }
    
    // 支付利息
    double interestPayment = repayTotalPrice - calcModel.businessTotalPrice;
    
    LXFHouseLoanResultModel *resultModel = [LXFHouseLoanResultModel new];
    resultModel.loanTotalPrice           = loanTotalPrice;
    resultModel.repayTotalPrice          = repayTotalPrice;
    resultModel.interestPayment          = interestPayment;
    resultModel.mortgageYear             = calcModel.mortgageYear;
    resultModel.mortgageMonth            = loanMonthCount;
    resultModel.avgMonthRepayment        = [[monthRepaymentArr firstObject] doubleValue];;
    resultModel.firstMonthRepayment      = avgMonthPrincipalRepayment;
    resultModel.monthRepaymentArr        = monthRepaymentArr;
    resultModel.remainderArr = yu_eArr;
    resultModel.ygbjArr = ygbjArr;
    if (monthRepaymentArr.count>= 2) {
        resultModel.decrease = [monthRepaymentArr[0] floatValue] - [monthRepaymentArr[1] floatValue];
    }
    NSMutableArray * lixiArr = [NSMutableArray array];
    for (int i = 0; i<loanMonthCount; i++) {
        // 每月还款
        // 公式：每月还款 + (贷款总额-每月还款*i) * 月利率
        double monthRepayment = avgMonthPrincipalRepayment
        + (loanTotalPrice - avgMonthPrincipalRepayment * i)
        * monthRate;
        [monthRepaymentArr addObject:[NSString stringWithFormat:@"%.2f", monthRepayment]];
        repayTotalPrice += monthRepayment;
        float lixi = monthRepayment - ( [monthRepaymentArr[0] floatValue] - [monthRepaymentArr[1] floatValue]);
        [lixiArr addObject:kString(@"%lf", lixi)];
    }
    resultModel.lixiArr = lixiArr;


    return resultModel;
}


/** =================================== 公积金贷款 =================================== */
#pragma mark - 公积金贷款
#pragma mark 按公积金贷款等额本息总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateFundLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:(LXFHouseLoanCalcModel *)calcModel {
    LXFLog(@"按公积金贷款等额本息总价计算(总价)");
    // 贷款总额
    double loanTotalPrice = calcModel.fundTotalPrice;
    // 贷款月数
    int loanMonthCount = calcModel.mortgageYear * 12;
    // 月利率
    double monthRate = calcModel.fundRate / 100.0 / 12.0;
    // 每月还款
    double avgMonthRepayment = loanTotalPrice*monthRate*powf(1+monthRate, loanMonthCount)/(powf(1+monthRate, loanMonthCount)-1);
    // 还款总额
    double repayTotalPrice = avgMonthRepayment*loanMonthCount;
    // 支付利息
    double interestPayment = repayTotalPrice-loanTotalPrice;
    
    // 每月还款数组
    NSMutableArray *monthRepaymentArr = [[NSMutableArray alloc] init];
    // 等本金 Arr
    NSMutableArray *ygbjArr = [[NSMutableArray alloc] init];
    //余额数组
    NSMutableArray*yu_eArr = [NSMutableArray array];


    for (int i = 0; i<loanMonthCount; i++) {
        [monthRepaymentArr addObject:[NSString stringWithFormat:@"%.2f", avgMonthRepayment]];

        float ygbj = loanTotalPrice * monthRate * powf( 1 + monthRate, i) / (powf( 1 + monthRate, loanMonthCount)-1);
        [ygbjArr addObject:kString(@"%.2f", ygbj)];
        [yu_eArr addObject:kString(@"%.2f", repayTotalPrice - ((i + 1) * avgMonthRepayment))];


    }
    
    LXFHouseLoanResultModel *resultModel = [LXFHouseLoanResultModel new];
    resultModel.loanTotalPrice           = loanTotalPrice;
    resultModel.repayTotalPrice          = repayTotalPrice;
    resultModel.interestPayment          = interestPayment;
    resultModel.mortgageYear             = calcModel.mortgageYear;
    resultModel.mortgageMonth            = loanMonthCount;
    resultModel.avgMonthRepayment        = avgMonthRepayment;
    resultModel.firstMonthRepayment      = [[monthRepaymentArr firstObject] doubleValue];;
    resultModel.monthRepaymentArr        = monthRepaymentArr;
    resultModel.ygbjArr = ygbjArr;
    resultModel.remainderArr = yu_eArr;
    return resultModel;
}
#pragma mark 按公积金贷款等额本金总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateFundLoanAsTotalPriceAndEqualPrincipalWithCalcModel:(LXFHouseLoanCalcModel *)calcModel {
    LXFLog(@"按公积金贷款等额本金总价计算(总价)");
    // 每月还款数组
    NSMutableArray *monthRepaymentArr = [[NSMutableArray alloc] init];
    // 贷款总额
    double loanTotalPrice = calcModel.fundTotalPrice;
    // 月利率
    double monthRate = calcModel.fundRate / 100.0 / 12.0;
    // 贷款月数
    int loanMonthCount = calcModel.mortgageYear * 12;
    // 每月所还本金（每月还款）
    double avgMonthPrincipalRepayment = loanTotalPrice / loanMonthCount;
    // 还款总额
    double repayTotalPrice = 0;
    for (int i             = 0; i<loanMonthCount; i++) {
        // 每月还款
        // 公式：每月还款 + (贷款总额-每月还款*i) * 月利率
        double monthRepayment = avgMonthPrincipalRepayment
        + (loanTotalPrice - avgMonthPrincipalRepayment * i)
        * monthRate;
        [monthRepaymentArr addObject:[NSString stringWithFormat:@"%.2f", monthRepayment]];
        repayTotalPrice += monthRepayment;
    }
    // 支付利息
    double interestPayment = repayTotalPrice - calcModel.fundTotalPrice;

    // 等本金 Arr
    NSMutableArray *ygbjArr = [[NSMutableArray alloc] init];

    //余额数组
    NSMutableArray*yu_eArr = [NSMutableArray array];

    for (int i = 0; i<loanMonthCount; i++) {

        float ygbj = loanTotalPrice * monthRate * powf( 1 + monthRate, i) / (powf( 1 + monthRate, loanMonthCount)-1);
        [ygbjArr addObject:kString(@"%.2f", ygbj)];

        [yu_eArr addObject: kString(@"%.2f", repayTotalPrice - (i+1)  * [monthRepaymentArr[0] floatValue] + i  * (i +1)/2 *  ([monthRepaymentArr[0] floatValue] - [monthRepaymentArr[1] floatValue]))];


    }


    
    LXFHouseLoanResultModel *resultModel = [LXFHouseLoanResultModel new];
    resultModel.loanTotalPrice           = loanTotalPrice;
    resultModel.repayTotalPrice          = repayTotalPrice;
    resultModel.interestPayment          = interestPayment;
    resultModel.mortgageYear             = calcModel.mortgageYear;
    resultModel.mortgageMonth            = loanMonthCount;
    resultModel.avgMonthRepayment        = avgMonthPrincipalRepayment;
    resultModel.firstMonthRepayment      = [[monthRepaymentArr firstObject] doubleValue];;
    resultModel.monthRepaymentArr        = monthRepaymentArr;
    resultModel.ygbjArr = ygbjArr;
    resultModel.remainderArr = yu_eArr;

    if (monthRepaymentArr.count>= 2) {
        resultModel.decrease = [monthRepaymentArr[0] floatValue] - [monthRepaymentArr[1] floatValue];
    }

    return resultModel;
}


/** =================================== 组合型贷款 =================================== */
#pragma mark - 组合型贷款
#pragma mark 按组合型贷款等额本息总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateCombinedLoanAsTotalPriceAndEqualPrincipalInterestWithCalcModel:(LXFHouseLoanCalcModel *)calcModel {
    LXFLog(@"按组合型贷款等额本息总价计算(总价)");
    // 商业贷款
    double businessTotalPrice = calcModel.businessTotalPrice;
    // 公积金贷款
    double fundTotalPrice = calcModel.fundTotalPrice;
    // 贷款月数
    int loanMonthCount = calcModel.mortgageYear * 12;
    // 银行月利率
    double bankMonthRate = calcModel.bankRate / 100.0 / 12.0;
    // 公积金月利率
    double fundMonthRate = calcModel.fundRate / 100.0 / 12.0;
    // 贷款总额
    double loanTotalPrice = businessTotalPrice + fundTotalPrice;
    // 每月还款
    double avgMonthRepayment =
    businessTotalPrice*bankMonthRate*powf(1+bankMonthRate, loanMonthCount)/(powf(1+bankMonthRate, loanMonthCount)-1)
    +
    fundTotalPrice*fundMonthRate*powf(1+fundMonthRate, loanMonthCount)/(powf(1+fundMonthRate, loanMonthCount)-1);
    // 还款总额
    double repayTotalPrice = avgMonthRepayment * loanMonthCount;
    // 支付利息
    double interestPayment = repayTotalPrice-loanTotalPrice;
    
    // 每月还款数组
    NSMutableArray *monthRepaymentArr = [[NSMutableArray alloc] init];
    // 月供本金数组
    NSMutableArray * ygbjArr = [[NSMutableArray alloc]init];

    //余额数组
    NSMutableArray*yu_eArr = [NSMutableArray array];

    for (int i = 0; i<loanMonthCount; i++) {
        [monthRepaymentArr addObject:[NSString stringWithFormat:@"%.2f", avgMonthRepayment]];

        float ygbj1 = businessTotalPrice * bankMonthRate * powf( 1 + bankMonthRate, i) / (powf( 1 + bankMonthRate, loanMonthCount)-1);  // 银行
        float ygbj2 = fundTotalPrice * fundMonthRate * powf( 1 + fundMonthRate, i) / (powf( 1 + fundMonthRate, loanMonthCount)-1); // 公积金
        [ygbjArr addObject: kString(@"%.2f", ygbj1 + ygbj2)];
        [yu_eArr addObject:kString(@"%.2f", repayTotalPrice - ((i + 1) * avgMonthRepayment))];


    }
    
    LXFHouseLoanResultModel *resultModel = [LXFHouseLoanResultModel new];
    resultModel.loanTotalPrice           = loanTotalPrice;
    resultModel.repayTotalPrice          = repayTotalPrice;
    resultModel.interestPayment          = interestPayment;
    resultModel.mortgageYear             = calcModel.mortgageYear;
    resultModel.mortgageMonth            = loanMonthCount;
    resultModel.avgMonthRepayment        = avgMonthRepayment;
    resultModel.firstMonthRepayment      = [[monthRepaymentArr firstObject] doubleValue];;
    resultModel.monthRepaymentArr        = monthRepaymentArr;
    resultModel.ygbjArr = ygbjArr;
    resultModel.remainderArr = yu_eArr;
    return resultModel;
}
#pragma mark 按组合型贷款等额本金总价计算(总价)
+ (LXFHouseLoanResultModel *)calculateCombinedLoanAsTotalPriceAndEqualPrincipalWithCalcModel:(LXFHouseLoanCalcModel *)calcModel {
    LXFLog(@"按组合型贷款等额本金总价计算(总价)");
    // 每月还款数组
    NSMutableArray *monthRepaymentArr = [[NSMutableArray alloc] init];
    // 商业贷款
    double businessTotalPrice = calcModel.businessTotalPrice;
    // 公积金贷款
    double fundTotalPrice = calcModel.fundTotalPrice;
    // 贷款月数
    int loanMonthCount = calcModel.mortgageYear * 12;
    // 银行月利率
    double bankMonthRate = calcModel.bankRate / 100.0 / 12.0;
    // 公积金月利率
    double fundMonthRate = calcModel.fundRate / 100.0 / 12.0;
    // 贷款总额
    double loanTotalPrice = businessTotalPrice + fundTotalPrice;
    // 商业每月所还本金（每月还款）
    double businessAvgMonthPrincipalRepayment = businessTotalPrice / loanMonthCount;
    // 公积金每月所还本金（每月还款）
    double fundAvgMonthPrincipalRepayment = fundTotalPrice / loanMonthCount;
    // 还款总额
    double repayTotalPrice = 0;
    for (int i = 0; i<loanMonthCount; i++) {
        // 每月还款
        // 公式：每月还款 + (贷款总额-每月还款*i) * 月利率
        double monthRepayment = businessAvgMonthPrincipalRepayment
        +(businessTotalPrice - businessAvgMonthPrincipalRepayment * i)
        *bankMonthRate
        +
        fundAvgMonthPrincipalRepayment
        +(fundTotalPrice - fundAvgMonthPrincipalRepayment * i)
        *fundMonthRate;
        [monthRepaymentArr addObject:[NSString stringWithFormat:@"%.2f", monthRepayment]];
        repayTotalPrice +=monthRepayment;
    }

    // 月供本金数组
    NSMutableArray * ygbjArr = [[NSMutableArray alloc]init];
    //余额数组
    NSMutableArray*yu_eArr = [NSMutableArray array];


    for (int i = 0; i<loanMonthCount; i++) {
        float ygbj1 = businessTotalPrice * bankMonthRate * powf( 1 + bankMonthRate, i) / (powf( 1 + bankMonthRate, loanMonthCount)-1);  // 银行
        float ygbj2 = fundTotalPrice * fundMonthRate * powf( 1 + fundMonthRate, i) / (powf( 1 + fundMonthRate, loanMonthCount)-1); // 公积金
        [ygbjArr addObject: kString(@"%.2f", ygbj1 + ygbj2)];
        [yu_eArr addObject: kString(@"%.2f", repayTotalPrice - (i+1)  * [monthRepaymentArr[0] floatValue] + i  * (i +1)/2 *  ([monthRepaymentArr[0] floatValue] - [monthRepaymentArr[1] floatValue]))];

    }

    // 支付利息
    double interestPayment = repayTotalPrice-loanTotalPrice;
    
    LXFHouseLoanResultModel *resultModel = [LXFHouseLoanResultModel new];
    resultModel.loanTotalPrice           = loanTotalPrice;
    resultModel.repayTotalPrice          = repayTotalPrice;
    resultModel.interestPayment          = interestPayment;
    resultModel.mortgageYear             = calcModel.mortgageYear;
    resultModel.mortgageMonth            = loanMonthCount;
    resultModel.avgMonthRepayment        = businessAvgMonthPrincipalRepayment + fundAvgMonthPrincipalRepayment;
    resultModel.firstMonthRepayment      = [[monthRepaymentArr firstObject] doubleValue];;
    resultModel.monthRepaymentArr        = monthRepaymentArr;
    resultModel.ygbjArr = ygbjArr;
    resultModel.remainderArr = yu_eArr;
    if (monthRepaymentArr.count>= 2) {
        resultModel.decrease = [monthRepaymentArr[0] floatValue] - [monthRepaymentArr[1] floatValue];
        
    }

    return resultModel;
}

@end

@implementation LXFHouseLoanCalcModel

@end

@implementation LXFHouseLoanResultModel

- (NSString *)description {
    return [NSString stringWithFormat:@"贷款总额: %f \n 还款总额: %f \n 支付利息: %f \n 按揭年数: %f \n 月均还款: %f \n 首月还款: %f \n ", self.loanTotalPrice, self.repayTotalPrice, self.interestPayment, self.mortgageYear, self.avgMonthRepayment, self.firstMonthRepayment];
}

@end
