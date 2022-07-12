//
//  NMBRFormatter.h
//  Test
//
//  Created by Kerr Marin Miller on 17/01/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NMBRFormatterNotation) {
    NMBRFormatterNotationShort,
    NMBRFormatterNotationLong
} NS_SWIFT_NAME(NMBRFormatter.Notation);

typedef NS_ENUM(NSInteger, NMBRFormatterGroupingStrategy) {
    NMBRFormatterGroupingStrategyOff,
    NMBRFormatterGroupingStrategyMin2,
    NMBRFormatterGroupingStrategyAuto,
    NMBRFormatterGroupingStrategyOnAligned,
    NMBRFormatterGroupingStrategyThousands
} NS_SWIFT_NAME(NMBRFormatter.GroupingStrategy);

@interface NMBRFormatter : NSObject

/// Creates a new instance of `NMBRFormatter`
/// @param locale the locale to use when formatting the number
- (instancetype)initWithLocale:(NSLocale *)locale;

/// Creates a new instance of `NMBRFormatter`
/// @param locale the locale to use when formatting the number
/// @param precision the maximum number of decimal points allowed in the conversion
- (instancetype)initWithLocale:(NSLocale *)locale
                  maxPrecision:(UInt8)precision;

/// Creates a new instance of `NMBRFormatter`
/// @param locale the locale to use when formatting the number
/// @param precision the maximum number of decimal points allowed in the conversion
/// @param notation  whether to use the short or long version of a number; for example .short will set the value 1_000_000 to 1M and .long will be 1 million.
- (instancetype)initWithLocale:(NSLocale *)locale
                  maxPrecision:(UInt8)precision
                      notation:(NMBRFormatterNotation)notation;

/// Creates a new instance of `NMBRFormatter`
/// @param locale the locale to use when formatting the number
/// @param precision the maximum number of decimal points allowed in the conversion
/// @param notation  whether to use the short or long version of a number; for example .short will set the value 1_000_000 to 1M and .long will be 1 million.
/// @param groupingStrategy the grouping strategy to follow. See `UNumberGroupingStrategy`.
- (instancetype)initWithLocale:(NSLocale *)locale
                  maxPrecision:(UInt8)precision
                      notation:(NMBRFormatterNotation)notation
              groupingStrategy:(NMBRFormatterGroupingStrategy)groupingStrategy;

/// Creates a new instance of `NMBRFormatter`
/// @param currencyCode  the currency code to use to create the formatter. If this currency code is not a valid value it will not be used.
- (instancetype)initWithCurrencyCode:(NSString *)currencyCode;

/// Creates a new instance of `NMBRFormatter`
/// @param locale the locale to use when formatting the number
/// @param currencyCode  the currency code to use to create the formatter. If this currency code is not a valid value it will not be used.
- (instancetype)initWithLocale:(NSLocale *)locale
                  currencyCode:(NSString *)currencyCode;

/// Creates a new instance of `NMBRFormatter`
/// @param locale the locale to use when formatting the number
/// @param precision the maximum number of decimal points allowed in the conversion
/// @param currencyCode  the currency code to use to create the formatter. If this currency code is not a valid value it will not be used.
- (instancetype)initWithLocale:(NSLocale *)locale
                  maxPrecision:(UInt8)precision
                  currencyCode:(NSString *)currencyCode;

/// Creates a new instance of `NMBRFormatter`
/// @param locale the locale to use when formatting the number
/// @param precision the maximum number of decimal points allowed in the conversion
/// @param notation  whether to use the short or long version of a number; for example .short will set the value 1_000_000 to 1M and .long will be 1 million.
/// @param currencyCode  the currency code to use to create the formatter. If this currency code is not a valid value it will not be used.
- (instancetype)initWithLocale:(NSLocale *)locale
                  maxPrecision:(UInt8)precision
                      notation:(NMBRFormatterNotation)notation
                  currencyCode:(NSString *)currencyCode;

/// Creates a new instance of `NMBRFormatter`
/// @param locale the locale to use when formatting the number
/// @param precision the maximum number of decimal points allowed in the conversion
/// @param notation  whether to use the short or long version of a number; for example .short will set the value 1_000_000 to 1M and .long will be 1 million.
/// @param groupingStrategy the grouping strategy to follow. See `UNumberGroupingStrategy`.
/// @param currencyCode  the currency code to use to create the formatter. If this currency code is not a valid value it will not be used.
- (instancetype)initWithLocale:(NSLocale *)locale
                  maxPrecision:(UInt8)precision
                      notation:(NMBRFormatterNotation)notation
              groupingStrategy:(NMBRFormatterGroupingStrategy)groupingStrategy
                  currencyCode:(NSString *)currencyCode;

/// Returns a string correctly formatted for the given number. If this formatter was created with a currency code, it will also include the currency.
/// @param number the number to format into a string.
- (nullable NSString *)stringFrom:(double)number __attribute__((__swift_name__("string(from:)")));

@end

NS_ASSUME_NONNULL_END
