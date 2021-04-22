//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct Text {
    public var value: String

    public init(_ value: String) {
        self.value = value
    }

    public init(paragraphs: [String]) {
        self.init(paragraphs.joined(separator: "\n"))
    }
}

extension Text: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension Text: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        var error: Error?
        let textNode = HTMLTextNode("", "")

        var shouldAppendLineBreak = false
        value.enumerateSubstrings(in: value.startIndex ..< value.endIndex, options: .byParagraphs) { _, paragraphRange, _, shouldStop in
            do {
                let childNode = HTMLTextNode(String(value[paragraphRange]), "")

                if shouldAppendLineBreak {
                    try textNode.addChildren(HTMLElement(.lineBreak, ""), childNode)
                } else {
                    try textNode.addChildren(childNode)
                }
                shouldAppendLineBreak = true
            } catch let err {
                error = err
                shouldStop = true
            }
        }

        if let error = error {
            throw error
        }

        return textNode
    }
}
