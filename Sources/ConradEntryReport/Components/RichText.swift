//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation
import SwiftSoup

public protocol RichText: HTMLComponent {
    associatedtype Content: HTMLComponent
    static var tag: Tag { get }
    var content: Content { get set }

    init(_ content: Content)
}

public extension RichText {
    init(_ content: () -> Content) {
        self.init(content())
    }

    init(_ string: String) where Content == Text {
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

public struct Bold<Content: HTMLComponent>: RichText {
    public static var tag: Tag { .bold }
    public var content: Content
    public init(_ content: Content) { self.content = content }
}

public struct Italicised<Content: HTMLComponent>: RichText {
    public static var tag: Tag { .italicised }
    public var content: Content
    public init(_ content: Content) { self.content = content }
}

public struct Strong<Content: HTMLComponent>: RichText {
    public static var tag: Tag { .strong }
    public var content: Content
    public init(_ content: Content) { self.content = content }
}

public struct Small<Content: HTMLComponent>: RichText {
    public static var tag: Tag { .small }
    public var content: Content
    public init(_ content: Content) { self.content = content }
}

public struct Subscript<Content: HTMLComponent>: RichText {
    public static var tag: Tag { .subscript }
    public var content: Content
    public init(_ content: Content) { self.content = content }
}

public struct Superscript<Content: HTMLComponent>: RichText {
    public static var tag: Tag { .superscript }
    public var content: Content
    public init(_ content: Content) { self.content = content }
}
