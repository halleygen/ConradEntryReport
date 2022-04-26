//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Foundation

#if !os(macOS)
    public enum LinuxDateComponentsFormatter {
        public static func localizedString(from dateComponents: DateComponents) -> String? {
            func appendToString(_ string: inout String, value: Int?, symbol: (singular: String, plural: String)) {
                guard let value = value, value != 0 else { return }

                if !string.isEmpty {
                    string += ", "
                }

                string += "\(value) \(value == 1 ? symbol.singular : symbol.plural)"
            }

            var string = ""
            appendToString(&string, value: dateComponents.year, symbol: ("yr", "yrs"))
            appendToString(&string, value: dateComponents.month, symbol: ("mth", "mths"))
            appendToString(&string, value: dateComponents.weekOfMonth, symbol: ("wk", "wks"))
            appendToString(&string, value: dateComponents.day, symbol: ("day", "days"))
            appendToString(&string, value: dateComponents.hour, symbol: ("hr", "hrs"))
            appendToString(&string, value: dateComponents.minute, symbol: ("min", "mins"))
            appendToString(&string, value: dateComponents.second, symbol: ("sec", "secs"))

            guard !string.isEmpty else { return nil }
            return string
        }
    }

    public enum LinuxListFormatter {
        public static func localizedString(byJoining values: [String]) -> String {
            switch values.count {
            case 0: return ""
            case 1: return values[0]

            default:
                var list = values.dropLast().joined(separator: ", ")
                values.last.map { list.append(", and \($0)") }
                return list
            }
        }

        public static func localizedString<T: LosslessStringConvertible>(byJoining values: [T]) -> String {
            localizedString(byJoining: values.map(String.init(_:)))
        }
    }

    public enum LinuxMeasurementFormatter {
        public static func localizedString<UnitType: Unit>(from measurement: Measurement<UnitType>, numberFormatter: NumberFormatter? = nil) -> String {
            let number = measurement.value as NSNumber
            var str = numberFormatter?.string(from: number) ?? NumberFormatter.localizedString(from: number, number: .decimal)
            str.append(measurement.unit.symbol)
            return str
        }
    }
#endif
