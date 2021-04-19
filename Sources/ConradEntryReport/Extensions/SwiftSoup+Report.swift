//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import SwiftSoup

public typealias HTMLDocument = SwiftSoup.Document
public typealias HTMLElement = SwiftSoup.Element
public typealias HTMLNode = SwiftSoup.Node

extension HTMLDocument {
    static var reportTemplate: HTMLDocument {
        let templateHTML = try! String(contentsOf: .reportTemplate, encoding: .utf8)
        return try! SwiftSoup.parse(templateHTML)
    }
}

extension HTMLElement {
    @inline(__always)
    func appendElement(_ tag: Tag) throws -> HTMLElement {
        try appendElement(tag.toString())
    }
}

extension Tag {
    static var body: Tag { .init("body") }
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
}
