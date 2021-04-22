//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct Text {
    public var value: HTMLTextConvertible

    public init(_ value: HTMLTextConvertible) {
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
        let valueString = value.htmlString(context: context)
        valueString.enumerateSubstrings(in: valueString.startIndex ..< valueString.endIndex, options: .byParagraphs) { _, paragraphRange, _, shouldStop in
            do {
                let childNode = HTMLTextNode(String(valueString[paragraphRange]), "")

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
