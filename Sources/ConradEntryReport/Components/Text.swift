//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct Text {
    public var value: String

    public init(value: String) {
        self.value = value
    }

    public init(paragraphs: [String]) {
        self.init(value: paragraphs.joined(separator: "\n"))
    }
}

extension Text: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value: value)
    }
}

extension Text: HTMLComponent {
    public func htmlElement(context: Report.Context) throws -> HTMLElement {
        let container = HTMLElement(.division, "")

        var caughtError: Error?
        value.enumerateSubstrings(in: value.startIndex ..< value.endIndex, options: .byParagraphs) { _, paragraphRange, _, shouldStop in
            do {
                let paragraphElement = try container.appendElement(.paragraph)
                try paragraphElement.text(String(value[paragraphRange]))
            } catch {
                caughtError = error
                shouldStop = true
            }
        }

        if let caughtError = caughtError {
            throw caughtError
        }

        return container
    }
}
