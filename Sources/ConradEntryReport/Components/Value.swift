//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Foundation
import Plot

public struct Value<T: HTMLTextConvertible>: Component {
    private let value: T
    @EnvironmentValue(.context) private var context

    public init(_ value: T) {
        self.value = value
    }

    public var body: Component {
        Text(value.htmlString(context: context!))
    }
}
