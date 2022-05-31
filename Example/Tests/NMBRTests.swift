import XCTest
import nmbr_icu

final class NMBRTests: XCTestCase {

    // MARK: Small numbers (i.e. less than the first grouping separator)
    func testSmallNumber_UK() {
        let formatter = NMBRFormatter(locale: "en_GB", maxPrecision: 0, notation: .short)

        XCTAssertEqual("0", formatter.formatNumber(0))
        XCTAssertEqual("1", formatter.formatNumber(1))
        XCTAssertEqual("999", formatter.formatNumber(999))
    }

    func testSmallNumber_India() {
        let formatter = NMBRFormatter(locale: "en_IN", maxPrecision: 0, notation: .short)

        XCTAssertEqual("0", formatter.formatNumber(0))
        XCTAssertEqual("1", formatter.formatNumber(1))
        XCTAssertEqual("999", formatter.formatNumber(999))
    }

    func testSmallNumber_ZH() {
        let formatter = NMBRFormatter(locale: "zh", maxPrecision: 0, notation: .short)

        XCTAssertEqual("0", formatter.formatNumber(0))
        XCTAssertEqual("1", formatter.formatNumber(1))
        XCTAssertEqual("999", formatter.formatNumber(999))
        XCTAssertEqual("9,999", formatter.formatNumber(9999))
    }

    // MARK: Long numbers (greater or equal to the first grouping separator)

    func testLargeNumber_Long_UK() {
        let formatter = NMBRFormatter(locale: "en_GB", maxPrecision: 1, notation: .long)

        XCTAssertEqual("1 thousand", formatter.formatNumber(1000))
        XCTAssertEqual("1.1 thousand", formatter.formatNumber(1100))

        XCTAssertEqual("1 million", formatter.formatNumber(1_000_000))
        XCTAssertEqual("1 billion", formatter.formatNumber(1_000_000_000))
        XCTAssertEqual("1 trillion", formatter.formatNumber(1_000_000_000_000))
    }

    func testVeryLargeNumber_Short_UK() {
        let formatter = NMBRFormatter(locale: "en_GB", maxPrecision: 0, notation: .short)

        XCTAssertEqual("1", formatter.formatNumber(1))
        XCTAssertEqual("1K", formatter.formatNumber(1_000))
        XCTAssertEqual("1M", formatter.formatNumber(1_000_000))
        XCTAssertEqual("1B", formatter.formatNumber(1_000_000_000))
        XCTAssertEqual("1T", formatter.formatNumber(1_000_000_000_000))
    }

    func testVeryLargeNumber_Short_JP() {
        let formatter = NMBRFormatter(locale: "ja_JP", maxPrecision: 0, notation: .short)

        XCTAssertEqual("1", formatter.formatNumber(1))
        XCTAssertEqual("1万", formatter.formatNumber(10_000))
        XCTAssertEqual("1億", formatter.formatNumber(100_000_000))
        XCTAssertEqual("1兆", formatter.formatNumber(1_000_000_000_000))
    }

    func testTooLargeNumber_Short_UK() {
        let formatter = NMBRFormatter(locale: "en_GB", maxPrecision: 0, notation: .short)

        // See what happens if the number is past the highest named group in the strings dict
        XCTAssertEqual("1,000T", formatter.formatNumber(1_000_000_000_000_000))
    }

    func testLargeNumber_Short_UK() {
        let formatter = NMBRFormatter(locale: "en_GB", maxPrecision: 1, notation: .short)

        XCTAssertEqual("1K", formatter.formatNumber(1000))
        XCTAssertEqual("1.1K", formatter.formatNumber(1100))
    }
}

final class NMBRPrecisionTests: XCTestCase {

    func testSmallNumbers() {
        let formatter = NMBRFormatter(locale: "en_GB", maxPrecision: 2, notation: .short)

        XCTAssertEqual("1", formatter.formatNumber(1))
        XCTAssertEqual("1", formatter.formatNumber(1.0))
        XCTAssertEqual("1.1", formatter.formatNumber(1.1))
        XCTAssertEqual("1.12", formatter.formatNumber(1.12))
        XCTAssertEqual("1.12", formatter.formatNumber(1.123))
        XCTAssertEqual("1.12", formatter.formatNumber(1.1234))
    }

    func testLargeNumbers() {
        let formatter = NMBRFormatter(locale: "en_GB", maxPrecision: 1, notation: .short)

        XCTAssertEqual("1K", formatter.formatNumber(1000))
        XCTAssertEqual("1.1K", formatter.formatNumber(1100))
        XCTAssertEqual("1.1K", formatter.formatNumber(1110))
        XCTAssertEqual("1.1K", formatter.formatNumber(1149))
        XCTAssertEqual("1.2K", formatter.formatNumber(1151))
    }
}

final class NSBRLocalisationTests: XCTestCase {

    func testFallbackLocalisations() {
        // Make sure that a fictional locale identifier doesn't crash the library
        let formatter = NMBRFormatter(locale: "aa_ZZ", maxPrecision: 0, notation: .short)

        // Should default back to "en"
        XCTAssertEqual("1K", formatter.formatNumber(1000))
    }
}

final class NMBRFormatterCurrencyTests: XCTestCase {

    func testGBP() {
        let formatter = NMBRFormatter(locale: "en_GB", maxPrecision: 0, notation: .short)

        XCTAssertEqual("£100", formatter.formatCurrency(100, currencyCode: "GBP"))
    }
}

final class NMBRFormatterCurrencyRightHandSideTests: XCTestCase {

    func testFRLocale() {
        let formatter = NMBRFormatter(locale: "fr_FR", maxPrecision: 0, notation: .short)

        XCTAssertEqual("100 k €", formatter.formatCurrency(100000, currencyCode: "EUR"))
    }

    func testESLocale() {
        let formatter = NMBRFormatter(locale: "es_ES", maxPrecision: 0, notation: .short)

        XCTAssertEqual("100 mil €", formatter.formatCurrency(100000, currencyCode: "EUR"))
        XCTAssertEqual("100 mil M€", formatter.formatCurrency(100_000_000_000, currencyCode: "EUR"))
    }
}
