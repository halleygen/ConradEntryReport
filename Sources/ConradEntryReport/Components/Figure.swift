//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Foundation
import Plot

public struct Figure: Component {
    public let image: Image
    public let timeStamp: Date?
    public let comment: String?

    @EnvironmentValue(.context) private var context

    public init(image: Image, timeStamp: Date?, comment: String?) {
        self.image = image
        self.timeStamp = timeStamp
        self.comment = comment
    }

    public var body: Component {
        Element(name: "figure") {
            image

            Element(name: "figcaption") {
                switch (timeStamp, comment) {
                case let (.some(timestamp), .some(comment)):
                    Text("\(comment) \(context!.localizedString(for: timestamp))")

                case let (.some(timestamp), .none):
                    Text(context!.localizedString(for: timestamp))

                case let (.none, .some(comment)):
                    Text(comment)

                case (.none, .none):
                    EmptyComponent()
                }
            }
        }
    }
}
