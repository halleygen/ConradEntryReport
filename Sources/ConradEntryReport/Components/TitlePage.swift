//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Foundation
import Plot

public struct TitlePage: Component {
    public let title: String
    public let vesselPhoto: Figure
    public let components: KeyValuePairs<String, HTMLTextConvertible?>

    @EnvironmentValue(.context) private var context

    public init(title: String, vesselPhoto: Figure, components: KeyValuePairs<String, HTMLTextConvertible?>) {
        self.title = title
        self.vesselPhoto = vesselPhoto
        self.components = components
    }

    public var body: Component {
        Element(name: "section") {
            H1(title)

            for (name, value) in components {
                if let value = value {
                    Text("\(name): \(value.htmlString(context: context!))")
                        .bold()
                }
            }

            vesselPhoto
        }
    }
}
