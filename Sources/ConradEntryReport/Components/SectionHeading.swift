//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation
import SwiftSoup

// MARK: - Heading

protocol Heading: ExpressibleByStringLiteral, HTMLComponent where StringLiteralType == String {
    static var tagName: String { get }
    var content: HTMLTextConvertible { get set }
    init(content: HTMLTextConvertible)
}

extension Heading {
    public init(stringLiteral value: StringLiteralType) {
        self.init(content: value)
    }

    public func htmlElement(context: Report.Context) throws -> HTMLElement {
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
}

// MARK: - SectionHeading

public struct SectionHeading: Heading {
    public static let tagName: String = "h2"
    public var content: HTMLTextConvertible

    public init(content: HTMLTextConvertible) {
        self.content = content
    }
}

// MARK: - SubSectionHeading

public struct SubSectionHeading: Heading {
    public static let tagName: String = "h3"
    public var content: HTMLTextConvertible

    public init(content: HTMLTextConvertible) {
        self.content = content
    }
}
