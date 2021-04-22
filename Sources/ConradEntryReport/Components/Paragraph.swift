//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import SwiftSoup

public struct Paragraph: HTMLComponent {
    public var children: ContiguousArray<HTMLComponent>

    public init(children: ContiguousArray<HTMLComponent>) {
        self.children = children
    }

    public init() {
        self.init(children: [])
    }

    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let paragraph = HTMLElement(.paragraph, "")

        for child in children {
            let childNode = try child.htmlNode(context: context)
            try paragraph.appendChild(childNode)
        }

        return paragraph
    }
}
