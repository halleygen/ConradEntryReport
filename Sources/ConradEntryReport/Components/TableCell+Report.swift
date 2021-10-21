//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Plot

public extension TableHeaderCell {
    init<T: HTMLTextConvertible>(_ value: T) {
        self.init(Value(value))
    }
}

public extension TableCell {
    init<T: HTMLTextConvertible>(_ value: T) {
        self.init(Value(value))
    }
}
