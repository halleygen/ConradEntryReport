//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Foundation

public extension Report {
    final class RenderContext {
        public let locale: Locale
        public let localTimeZone: TimeZone

        public var calendar: Calendar { locale.calendar }

        private var numberFormatterCache: [NumberFormatter.Style: NumberFormatter] = [:]
        private var dateFormatterCache: [DateTimeStyle: DateFormatter] = [:]
        private var dateIntervalFormatterCache: [DateTimeStyle: DateIntervalFormatter] = [:]

        #if os(macOS)
            private var dateComponentsFormatterCache: [NSCalendar.Unit: DateComponentsFormatter] = [:]
            private lazy var measurementFormatter: MeasurementFormatter = makeMeasurementFormatter()
            private lazy var listFormatter: ListFormatter = makeListFormatter()
        #endif

        init(localTimeZone: TimeZone, locale: Locale) {
            self.localTimeZone = localTimeZone
            self.locale = locale
        }
    }
}

// MARK: - Number Formatting

public extension Report.RenderContext {
    func localizedString<T: BinaryInteger>(for value: T) -> String {
        let number = Int64(exactly: value)! as NSNumber
        return localizedString(for: number, style: .none)
    }

    func localizedString<T: BinaryFloatingPoint>(for value: T) -> String {
        let number = Double(exactly: value)! as NSNumber
        return localizedString(for: number, style: .decimal)
    }

    func localizedString(for number: NSNumber, style: NumberFormatter.Style) -> String {
        if let formatter = numberFormatterCache[style] {
            return formatter.string(from: number)!
        } else {
            let formatter = makeNumberFormatter(style: style)
            numberFormatterCache[style] = formatter
            return formatter.string(from: number)!
        }
    }
}

// MARK: - Date Formatting

public extension Report.RenderContext {
    func localizedString(for date: Date, dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .short) -> String {
        let style = DateTimeStyle(dateStyle: dateStyle, timeStyle: timeStyle)
        if let formatter = dateFormatterCache[style] {
            return formatter.string(from: date)
        } else {
            let formatter = makeDateFormatter(dateStyle: dateStyle, timeStyle: timeStyle)
            dateFormatterCache[style] = formatter
            return formatter.string(from: date)
        }
    }

    func localizedString(for interval: DateInterval, dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .short) -> String {
        let style = DateTimeStyle(dateStyle: dateStyle, timeStyle: timeStyle)
        if let formatter = dateIntervalFormatterCache[style] {
            return formatter.string(from: interval)!
        } else {
            let formatter = makeDateIntervalFormatter(dateStyle: dateStyle, timeStyle: timeStyle)
            dateIntervalFormatterCache[style] = formatter
            return formatter.string(from: interval)!
        }
    }

    func localizedString(forDurationIn interval: DateInterval, allowedUnits: NSCalendar.Unit) -> String {
        #if os(macOS)
            let dateComponentsFormatter: DateComponentsFormatter
            if let cached = dateComponentsFormatterCache[allowedUnits] {
                dateComponentsFormatter = cached
            } else {
                let new = makeDateComponentsFormatter(allowedUnits: allowedUnits)
                dateComponentsFormatterCache[allowedUnits] = new
                dateComponentsFormatter = new
            }
            return dateComponentsFormatter.string(from: interval.start, to: interval.end)!
        #else
            let components = Calendar.Component.from(allowedUnits)
            let dateComponents = calendar.dateComponents(components, from: interval.start, to: interval.end)
            return LinuxDateComponentsFormatter.localizedString(from: dateComponents)!
        #endif
    }
}

// MARK: - Measurement Formatting

public extension Report.RenderContext {
    func localizedString<UnitType: Unit>(for measurement: Measurement<UnitType>) -> String {
        #if os(macOS)
            return measurementFormatter.string(from: measurement)
        #else
            let numberFormatter: NumberFormatter
            if let cached = numberFormatterCache[.decimal] {
                numberFormatter = cached
            } else {
                let new = makeNumberFormatter(style: .decimal)
                numberFormatterCache[.decimal] = new
                numberFormatter = new
            }
            return LinuxMeasurementFormatter.localizedString(from: measurement, numberFormatter: numberFormatter)
        #endif
    }
}

// MARK: - List Formatting

public extension Report.RenderContext {
    func localizedString(for items: [String]) -> String {
        #if os(macOS)
            return listFormatter.string(from: items) ?? ""
        #else
            return LinuxListFormatter.localizedString(byJoining: items)
        #endif
    }
}

// MARK: - Private

private struct DateTimeStyle: Hashable {
    let dateStyle: DateFormatter.Style
    let timeStyle: DateFormatter.Style
}

private extension Report.RenderContext {
    func makeNumberFormatter(style: NumberFormatter.Style) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.locale = locale
        formatter.formattingContext = .standalone
        formatter.hasThousandSeparators = true
        formatter.usesGroupingSeparator = true

        switch style {
        case .none:
            formatter.allowsFloats = false
            formatter.groupingSize = 3
            formatter.maximumFractionDigits = 0

        case .decimal:
            formatter.allowsFloats = true
            formatter.groupingSize = 3
            formatter.maximumFractionDigits = 3

        default:
            break
        }
        return formatter
    }

    func makeDateFormatter(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = localTimeZone
        formatter.locale = locale
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter
    }

    func makeDateIntervalFormatter(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> DateIntervalFormatter {
        let formatter = DateIntervalFormatter()
        formatter.calendar = calendar
        formatter.timeZone = localTimeZone
        formatter.locale = locale
        formatter.dateStyle = DateIntervalFormatter.Style(rawValue: dateStyle.rawValue)!
        formatter.timeStyle = DateIntervalFormatter.Style(rawValue: timeStyle.rawValue)!
        return formatter
    }

    #if os(macOS)
        func makeDateComponentsFormatter(allowedUnits: NSCalendar.Unit) -> DateComponentsFormatter {
            let formatter = DateComponentsFormatter()
            formatter.collapsesLargestUnit = true
            formatter.calendar = calendar
            formatter.zeroFormattingBehavior = .dropAll
            formatter.unitsStyle = .short
            formatter.allowedUnits = allowedUnits
            return formatter
        }

        func makeMeasurementFormatter() -> MeasurementFormatter {
            let formatter = MeasurementFormatter()
            formatter.locale = locale
            formatter.unitOptions = .providedUnit
            formatter.numberFormatter.maximumFractionDigits = 3
            return formatter
        }

        func makeListFormatter() -> ListFormatter {
            let formatter = ListFormatter()
            formatter.locale = locale
            return formatter
        }
    #endif
}
