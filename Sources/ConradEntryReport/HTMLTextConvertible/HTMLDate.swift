//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct HTMLDate: Hashable {
    public var value: Date
    public var dateStyle: DateFormatter.Style
    public var timeStyle: DateFormatter.Style

    public init(_ value: Date, dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .short) {
        self.value = value
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}

extension HTMLDate: Comparable {
    public static func < (lhs: HTMLDate, rhs: HTMLDate) -> Bool {
        lhs.value < rhs.value
    }
}

extension HTMLDate: HTMLTextConvertible {
    public func htmlString(context: Report.RenderContext) -> String {
        context.localizedString(for: value, dateStyle: dateStyle, timeStyle: timeStyle)
    }
}
