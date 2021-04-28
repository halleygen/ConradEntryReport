//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation
import SwiftSoup

// MARK: - Heading

protocol Heading: ExpressibleByStringLiteral, HTMLComponent {
    static var tagName: String { get }
    var content: HTMLTextConvertible { get set }
    init(content: HTMLTextConvertible)
}

extension Heading {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let element = HTMLElement(Tag(Self.tagName), "")
        try element.text(content.htmlString(context: context))
        return element
    }
}

// MARK: - DocumentHeading

public struct DocumentHeading: Heading {
    public static let tagName: String = "h1"
    public var content: HTMLTextConvertible

    public init(content: HTMLTextConvertible) {
        self.content = content
    }

    public init(stringLiteral value: String) {
        self.init(content: value)
    }
}

// MARK: - SectionHeading

public struct SectionHeading: Heading {
    public static let tagName: String = "h2"
    public var content: HTMLTextConvertible

    public init(content: HTMLTextConvertible) {
        self.content = content
    }

    public init(stringLiteral value: String) {
        self.init(content: value)
    }
}

// MARK: - SubsectionHeading

public struct SubsectionHeading: Heading {
    public static let tagName: String = "h3"
    public var content: HTMLTextConvertible

    public init(content: HTMLTextConvertible) {
        self.content = content
    }

    public init(stringLiteral value: String) {
        self.init(content: value)
    }
}
