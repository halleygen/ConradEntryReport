//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct HTMLDateInterval: Hashable {
    let interval: DateInterval
    let dateStyle: DateFormatter.Style
    let timeStyle: DateFormatter.Style
}

public extension HTMLDateInterval {
    init(from start: Date, to finish: Date, dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .short) {
        self.init(interval: DateInterval(start: start, end: finish), dateStyle: dateStyle, timeStyle: timeStyle)
    }

    init(in interval: DateInterval, dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .short) {
        self.interval = interval
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}

extension HTMLDateInterval: HTMLTextConvertible {
    public func htmlString(context: Context) -> String {
        context.localizedString(for: interval, dateStyle: dateStyle, timeStyle: timeStyle)
    }
}
