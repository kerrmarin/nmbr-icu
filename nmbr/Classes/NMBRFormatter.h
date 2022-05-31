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
};

typedef NS_ENUM(NSInteger, NMBRFormatterGroupingStrategy) {
    NMBRFormatterGroupingStrategyOff,
    NMBRFormatterGroupingStrategyMin2,
    NMBRFormatterGroupingStrategyAuto,
    NMBRFormatterGroupingStrategyOnAligned,
    NMBRFormatterGroupingStrategyThousands
};

@interface NMBRFormatter : NSObject

- (nullable NSString *)formatNumber:(double)number;
- (nullable NSString *)formatCurrency:(double)number currencyCode:(NSString *)currencyCode;

- (instancetype)initWithLocale:(NSString *)locale;

- (instancetype)initWithLocale:(NSString *)locale
                  maxPrecision:(int)precision;

- (instancetype)initWithLocale:(NSString *)locale
                  maxPrecision:(int)precision
                      notation:(NMBRFormatterNotation)notation;

- (instancetype)initWithLocale:(NSString *)locale
                  maxPrecision:(int)precision
                      notation:(NMBRFormatterNotation)notation
              groupingStrategy:(NMBRFormatterGroupingStrategy)groupingStrategy;

@end

NS_ASSUME_NONNULL_END
