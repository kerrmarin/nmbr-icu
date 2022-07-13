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
    icu::number::LocalizedNumberFormatter formatter;
}

@end

@implementation NMBRFormatter

- (nonnull instancetype)init {
    return [self initWithLocale:[NSLocale currentLocale]];
}

-(nonnull instancetype)initWithLocale:(NSLocale *)locale {
    return [self initWithLocale:locale
                   maxPrecision:2];
}

- (nonnull instancetype)initWithLocale:(NSLocale *)locale
                          maxPrecision:(UInt8)precision {
    return [self initWithLocale:locale
                   maxPrecision:precision
                       notation:NMBRFormatterNotationShort];
}

- (nonnull instancetype)initWithLocale:(NSLocale *)locale
                          maxPrecision:(UInt8)precision
                              notation:(NMBRFormatterNotation)notation {
    return [self initWithLocale:locale
                   maxPrecision:precision
                       notation:notation
               groupingStrategy:NMBRFormatterGroupingStrategyAuto];
}

- (nonnull instancetype)initWithLocale:(NSLocale *)locale
                          maxPrecision:(UInt8)precision
                              notation:(NMBRFormatterNotation)notation
                      groupingStrategy:(NMBRFormatterGroupingStrategy)groupingStrategy {
    if (self = [super init]) {
        icu::number::Notation notat = notationFromNMBRFormatterNotation(notation);
        UNumberGroupingStrategy strategy = uNumberStrategyFromNMBRFormatterGroupingStrategy(groupingStrategy);
        formatter = icu::number::NumberFormatter::withLocale(locale.localeIdentifier.UTF8String)
            .notation(notat)
            .grouping(strategy)
            .precision(icu::number::Precision::maxFraction(precision));
    }
    return self;
}

- (instancetype)initWithCurrencyCode:(NSString *)currencyCode {
    return [self initWithLocale: [NSLocale currentLocale]
                   currencyCode: currencyCode];
}

- (instancetype)initWithLocale:(NSLocale *)locale
                  currencyCode:(NSString *)currencyCode {
    return [self initWithLocale: locale
                   maxPrecision: 2
                   currencyCode: currencyCode];
}

- (instancetype)initWithLocale:(NSLocale *)locale
                  maxPrecision:(UInt8)precision
                  currencyCode:(NSString *)currencyCode {
    return [self initWithLocale: locale
                   maxPrecision: precision
                       notation: NMBRFormatterNotationShort
                   currencyCode: currencyCode];
}

- (instancetype)initWithLocale:(NSLocale *)locale
                  maxPrecision:(UInt8)precision
                      notation:(NMBRFormatterNotation)notation
                  currencyCode:(NSString *)currencyCode {
    return [self initWithLocale:locale
                   maxPrecision:precision
                       notation:notation
               groupingStrategy:NMBRFormatterGroupingStrategyAuto
                   currencyCode:currencyCode];
}

- (instancetype)initWithLocale:(NSLocale *)locale
                  maxPrecision:(UInt8)precision
                      notation:(NMBRFormatterNotation)notation
              groupingStrategy:(NMBRFormatterGroupingStrategy)groupingStrategy
                  currencyCode:(NSString *)currencyCode {
    if (self = [super init]) {
        UErrorCode status = U_ZERO_ERROR;
        icu::CurrencyUnit currencyUnit = icu::CurrencyUnit(currencyCode.UTF8String, status);
        if (U_FAILURE(status)) {
            return [self initWithLocale:locale
                           maxPrecision:precision
                               notation:notation
                       groupingStrategy:groupingStrategy];
        } else {
            icu::number::Notation notat = notationFromNMBRFormatterNotation(notation);
            UNumberGroupingStrategy strategy = uNumberStrategyFromNMBRFormatterGroupingStrategy(groupingStrategy);
            formatter = icu::number::NumberFormatter::withLocale(locale.localeIdentifier.UTF8String)
                .notation(notat)
                .grouping(strategy)
                .precision(icu::number::Precision::maxFraction(precision))
                .unit(currencyUnit);
        }
    }
    return self;
}

- (nullable NSString *)stringFrom:(double)number {
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

icu::number::Notation notationFromNMBRFormatterNotation(NMBRFormatterNotation notation) {
    switch (notation) {
        case NMBRFormatterNotationShort:
            return icu::number::Notation::compactShort();
        case NMBRFormatterNotationLong:
            return icu::number::Notation::compactLong();
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
