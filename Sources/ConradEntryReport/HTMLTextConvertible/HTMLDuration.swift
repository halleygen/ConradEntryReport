//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct HTMLDuration {
    private let interval: DateInterval
    private let allowedUnits: NSCalendar.Unit

    public init(interval: DateInterval, allowedUnits: NSCalendar.Unit = [.day, .hour, .minute]) {
        self.interval = interval
        self.allowedUnits = allowedUnits
    }

    public init(start: Date, finish: Date, allowedUnits: NSCalendar.Unit = [.day, .hour, .minute]) {
        self.init(interval: DateInterval(start: start, end: finish), allowedUnits: allowedUnits)
    }
}

extension HTMLDuration: HTMLTextConvertible {
    public func htmlString(context: Context) -> String {
        context.localizedString(forDurationIn: interval, allowedUnits: allowedUnits)
    }
}
