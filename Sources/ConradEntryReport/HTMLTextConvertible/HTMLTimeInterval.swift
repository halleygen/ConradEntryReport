//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct HTMLDuration {
    private let interval: DateInterval

    public init(interval: DateInterval) {
        self.interval = interval
    }

    public init(start: Date, finish: Date) {
        self.init(interval: DateInterval(start: start, end: start))
    }
}

extension HTMLDuration: HTMLTextConvertible {
    public func htmlString(context: Report.Context) -> String {
        context.localizedString(forDurationIn: interval)
    }
}