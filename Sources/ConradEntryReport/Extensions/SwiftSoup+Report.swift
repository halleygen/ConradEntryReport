//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import SwiftSoup

public typealias HTMLDocument = SwiftSoup.Document
public typealias HTMLElement = SwiftSoup.Element
public typealias HTMLTextNode = SwiftSoup.TextNode
public typealias HTMLNode = SwiftSoup.Node
public typealias HTMLTag = SwiftSoup.Tag

extension HTMLDocument {
    static var reportTemplate: HTMLDocument {
        try! SwiftSoup.parse("<!DOCTYPE html><html lang=\"en\"></html>")
    }
}

extension HTMLElement {
    @inline(__always)
    func appendElement(_ tag: Tag) throws -> HTMLElement {
        try appendElement(tag.toString())
    }
}

extension Tag {
    static var head: Tag { .init("head") }
    static var meta: Tag { .init("meta") }
    static var body: Tag { .init("body") }
    static var title: Tag { .init("title") }
    static var style: Tag { .init("style") }
    static var section: Tag { .init("section") }
    static var paragraph: Tag { .init("p") }
    static var division: Tag { .init("div") }
    static var tableRow: Tag { .init("tr") }
    static var table: Tag { .init("table") }
    static var tableHeader: Tag { .init("thead") }
    static var tableBody: Tag { .init("tbody") }
    static var tableHeaderCell: Tag { .init("th") }
    static var tableDataCell: Tag { .init("td") }
    static var caption: Tag { .init("caption") }
    static var figure: Tag { .init("figure") }
    static var figureCaption: Tag { .init("figcaption") }
    static var image: Tag { .init("img") }
    static var orderedList: Tag { .init("ol") }
    static var unorderedList: Tag { .init("ul") }
    static var listItem: Tag { .init("li") }
    static var bold: Tag { .init("b") }
    static var italicised: Tag { .init("i") }
    static var strong: Tag { .init("strong") }
    static var small: Tag { .init("small") }
    static var `subscript`: Tag { .init("sub") }
    static var superscript: Tag { .init("sup") }
    static var lineBreak: Tag { .init("br") }
    static var h4: Tag { .init("h4") }
}
