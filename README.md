# nmbr-icu (a fork of nmbr)

[![CI Status](https://img.shields.io/travis/deanWombourne/nmbr.svg?style=flat)](https://travis-ci.org/deanWombourne/nmbr)
[![Version](https://img.shields.io/cocoapods/v/nmbr.svg?style=flat)](https://cocoapods.org/pods/nmbr)
[![License](https://img.shields.io/cocoapods/l/nmbr.svg?style=flat)](https://cocoapods.org/pods/nmbr)
[![Platform](https://img.shields.io/cocoapods/p/nmbr.svg?style=flat)](https://cocoapods.org/pods/nmbr)

This pod is a (hopefully) very small library to short format numbers like this: http://cldr.unicode.org/translation/numbers-currency/number-patterns#TOC-Compact-decimal-formatting-Short-Numbers.

It's main purpose is for formatting pricing information (though it will format any number) - for example 1,100,000 would become £1.1M in en_GB, but would become £110万 in ja_JP.

It should

- deal with localisation (i.e. some locales group by 4 digits, not 3)
- deal with pricing correctly (i.e. put the right currency symbol in the right place)
- deal with long/short versions i.e. 1M vs. 1 million.

Long term, this should just be handled in `Foundation` - there shouldn't really be a need for this pod.

## Installation

nmbr is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'nmbr-icu'
```

## Usage

Create a NMBRFormatter

```swift
let formatter = NMBRFormatter(locale: "en_GB", maxPrecision: 0, notation: .short)
```

Use the formatter

```swift
myLabel.text = formatter.string(from: 123.456) // "£123.46"
```

## License

nmbr-icu is available under the MIT license. See the LICENSE file for more info.
