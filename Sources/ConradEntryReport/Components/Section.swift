//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation
import Plot

public struct Section<Content: Component>: Component {
    public let title: String
    @ComponentBuilder public let content: () -> Content

    public init(title: String, @ComponentBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    public var body: Component {
        Element(name: "section") {
            H2(title)
            content()
        }
    }
}
