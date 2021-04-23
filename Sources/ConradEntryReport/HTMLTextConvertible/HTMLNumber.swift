//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct HTMLNumber {
    private let mode: Mode
    private let style: NumberFormatter.Style

    private enum Mode {
        case int(Int), double(Double)

        var nsNumber: NSNumber {
            switch self {
            case let .double(doubleValue): return doubleValue as NSNumber
            case let .int(intValue): return intValue as NSNumber
            }
        }
    }

    public init(_ intValue: Int, style: NumberFormatter.Style = .none) {
        self.mode = .int(intValue)
        self.style = style
    }

    public init(_ doubleValue: Double, style: NumberFormatter.Style = .decimal) {
        self.mode = .double(doubleValue)
        self.style = style
    }
}

extension HTMLNumber: HTMLTextConvertible {
    public func htmlString(context: Report.Context) -> String {
        context.localizedString(for: mode.nsNumber, style: style)
    }
}
