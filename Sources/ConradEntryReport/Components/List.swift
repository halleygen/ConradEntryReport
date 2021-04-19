//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import SwiftSoup

public struct List {
    public var kind: Kind
    public var items: ContiguousArray<HTMLTextConvertible>
    public var emptyText: String

    public init(_ kind: Kind, items: ContiguousArray<HTMLTextConvertible>, emptyText: String = "None") {
        self.kind = kind
        self.items = items
        self.emptyText = emptyText
    }
}

public extension List {
    init(_ kind: Kind, items: [HTMLTextConvertible], emptyText: String = "None") {
        self.init(kind, items: ContiguousArray(items), emptyText: emptyText)
    }
}

public extension List {
    enum Kind {
        case ordered, unordered

        var tag: Tag {
            switch self {
            case .ordered: return .orderedList
            case .unordered: return .unorderedList
            }
        }
    }
}

extension List: HTMLComponent {
    public func htmlElement(context: Report.Context) throws -> HTMLElement {
        let listElement = HTMLElement(kind.tag, "")

        guard !items.isEmpty else {
            let noneElement = try listElement.appendElement(.listItem)
            try noneElement.text("None")
            return listElement
        }

        for item in items {
            let itemElement = try listElement.appendElement(.listItem)
            try itemElement.text(item.htmlString(context: context))
        }
        return listElement
    }
}
