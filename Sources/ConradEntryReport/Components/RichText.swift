//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation
import SwiftSoup

public protocol RichText: HTMLComponent {
    static var tag: Tag { get }
    var content: HTMLComponent { get set }

    init(_ content: HTMLComponent)
}

public extension RichText {
    init(_ content: () throws -> HTMLComponent) rethrows {
        self.init(try content())
    }

    init(_ string: String) {
        self.init(Text(string))
    }

    func htmlNode(context: Report.Context) throws -> HTMLNode {
        let contentElement = try content.htmlNode(context: context)

        let element = HTMLElement(Self.tag, "")
        try element.appendChild(contentElement)
        return element
    }
}

// MARK: - Implementations

public struct Bold: RichText {
    public static var tag: Tag { .bold }
    public var content: HTMLComponent
    public init(_ content: HTMLComponent) { self.content = content }
}

public struct Italicised: RichText {
    public static var tag: Tag { .italicised }
    public var content: HTMLComponent
    public init(_ content: HTMLComponent) { self.content = content }
}

public struct Strong: RichText {
    public static var tag: Tag { .strong }
    public var content: HTMLComponent
    public init(_ content: HTMLComponent) { self.content = content }
}

public struct Small: RichText {
    public static var tag: Tag { .small }
    public var content: HTMLComponent
    public init(_ content: HTMLComponent) { self.content = content }
}

public struct Subscript: RichText {
    public static var tag: Tag { .subscript }
    public var content: HTMLComponent
    public init(_ content: HTMLComponent) { self.content = content }
}

public struct Superscript: RichText {
    public static var tag: Tag { .superscript }
    public var content: HTMLComponent
    public init(_ content: HTMLComponent) { self.content = content }
}

public struct H4: RichText {
    public static var tag: Tag { .h4 }
    public var content: HTMLComponent
    public init(_ content: HTMLComponent) { self.content = content }
}
