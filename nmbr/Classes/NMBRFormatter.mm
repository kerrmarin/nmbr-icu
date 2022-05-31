//
//  NMBRFormatter.m
//  nmbr
//
//  Created by Kerr Marin Miller on 17/01/2021.
//

#import "NMBRFormatter.h"

#include <string>
#include <unicode/unistr.h>
#include <unicode/numberformatter.h>
#include <unicode/unum.h>

@interface NMBRFormatter () {
    icu_71::number::LocalizedNumberFormatter formatter;
}

@end

@implementation NMBRFormatter

- (nonnull instancetype)init {
    return [self initWithLocale:[NSLocale currentLocale].localeIdentifier];
}

-(nonnull instancetype)initWithLocale:(NSString *)locale {
    return [self initWithLocale:locale
                   maxPrecision:2];
}

- (nonnull instancetype)initWithLocale:(NSString *)locale maxPrecision:(int)precision {
    return [self initWithLocale:locale
                   maxPrecision:precision
                       notation:NMBRFormatterNotationShort];
}

- (nonnull instancetype)initWithLocale:(NSString *)locale maxPrecision:(int)precision notation:(NMBRFormatterNotation)notation {
    return [self initWithLocale:locale
                   maxPrecision:precision
                       notation:notation
               groupingStrategy:NMBRFormatterGroupingStrategyAuto];
}

- (nonnull instancetype)initWithLocale:(NSString *)locale
                          maxPrecision:(int)precision
                              notation:(NMBRFormatterNotation)notation
                      groupingStrategy:(NMBRFormatterGroupingStrategy)groupingStrategy {
    if (self = [super init]) {
        icu_71::number::Notation notat = notationFromNMBRFormatterNotation(notation);
        UNumberGroupingStrategy strategy = uNumberStrategyFromNMBRFormatterGroupingStrategy(groupingStrategy);
        formatter = icu::number::NumberFormatter::with()
            .notation(notat)
            .grouping(strategy)
            .locale(locale.UTF8String)
            .precision(icu::number::Precision::maxFraction(precision));
    }
    return self;
}

- (nullable NSString *)formatNumber:(double)number {
    UErrorCode status = U_ZERO_ERROR;
    UErrorCode stringStatus = U_ZERO_ERROR;
    std::string str;
    formatter
        .formatDouble(number, status)
        .toString(stringStatus)
        .toUTF8String(str);

    if(U_FAILURE(status) || U_FAILURE(stringStatus)) {
        return nil;
    }

    return [NSString stringWithUTF8String:str.c_str()];
}

- (nullable NSString *)formatCurrency:(double)number currencyCode:(NSString *)currencyCode {
    UErrorCode status = U_ZERO_ERROR;
    UErrorCode stringStatus = U_ZERO_ERROR;
    std::string str;
    formatter
        .unit(icu_71::CurrencyUnit(currencyCode.UTF8String, status))
        .formatDouble(number, status)
        .toString(stringStatus)
        .toUTF8String(str);

    if(U_FAILURE(status) || U_FAILURE(stringStatus)) {
        return nil;
    }

    return [NSString stringWithUTF8String:str.c_str()];
}

icu_71::number::Notation notationFromNMBRFormatterNotation(NMBRFormatterNotation notation) {
    switch (notation) {
        case NMBRFormatterNotationShort:
            return icu_71::number::Notation::compactShort();
        case NMBRFormatterNotationLong:
            return icu_71::number::Notation::compactLong();
    }
}

UNumberGroupingStrategy uNumberStrategyFromNMBRFormatterGroupingStrategy(NMBRFormatterGroupingStrategy strategy) {
    switch (strategy) {
        case NMBRFormatterGroupingStrategyOff:
            return UNUM_GROUPING_OFF;
        case NMBRFormatterGroupingStrategyMin2:
            return UNUM_GROUPING_MIN2;
        case NMBRFormatterGroupingStrategyAuto:
            return UNUM_GROUPING_AUTO;
        case NMBRFormatterGroupingStrategyOnAligned:
            return UNUM_GROUPING_ON_ALIGNED;
        case NMBRFormatterGroupingStrategyThousands:
            return UNUM_GROUPING_THOUSANDS;
    }
}

@end
