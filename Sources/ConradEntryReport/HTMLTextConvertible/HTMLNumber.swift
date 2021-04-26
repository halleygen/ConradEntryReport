//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct HTMLNumber {
    private let number: NSNumber
    private let style: NumberFormatter.Style?

    public init(_ number: NSNumber, overridingStyle style: NumberFormatter.Style? = nil) {
        self.number = number.copy() as! NSNumber
        self.style = style
    }

    public init(_ intValue: Int, overridingStyle style: NumberFormatter.Style? = nil) {
        self.number = intValue as NSNumber
        self.style = style
    }

    public init(_ doubleValue: Double, overridingStyle style: NumberFormatter.Style? = nil) {
        self.number = doubleValue as NSNumber
        self.style = style
    }
}

extension HTMLNumber: HTMLTextConvertible {
    public func htmlString(context: Report.Context) -> String {
        context.localizedString(for: number, style: resolveStyle())
    }

    private func resolveStyle() -> NumberFormatter.Style {
        style ?? (CFNumberIsFloatType(number) ? .decimal : .none)
    }
}
