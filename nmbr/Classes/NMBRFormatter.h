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

- (nullable NSString *)stringFrom:(double)number __attribute__((__swift_name__("string(from:)")));
- (nullable NSString *)stringFrom:(double)number currencyCode:(NSString *)currencyCode __attribute__((__swift_name__("string(from:currencyCode:)")));

- (instancetype)initWithLocale:(NSString *)locale;

- (instancetype)initWithLocale:(NSString *)locale
                  maxPrecision:(UInt8)precision;

- (instancetype)initWithLocale:(NSString *)locale
                  maxPrecision:(UInt8)precision
                      notation:(NMBRFormatterNotation)notation;

- (instancetype)initWithLocale:(NSString *)locale
                  maxPrecision:(UInt8)precision
                      notation:(NMBRFormatterNotation)notation
              groupingStrategy:(NMBRFormatterGroupingStrategy)groupingStrategy;

@end

NS_ASSUME_NONNULL_END
