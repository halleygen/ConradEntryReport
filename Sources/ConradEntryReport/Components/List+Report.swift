//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Plot

public struct OrderedList<Items: Collection, Content: Component, Empty: Component>: Component {
    public var items: Items
    @ComponentBuilder public var content: (Items.Element) -> Content
    public var emptyComponent: Empty

    public init(_ items: Items, @ComponentBuilder content: @escaping (Items.Element) -> Content, @ComponentBuilder emptyComponent: () -> Empty) {
        self.items = items
        self.content = content
    }

    public init(_ items: Items, emptyText: String, @ComponentBuilder content: @escaping (Items.Element) -> Content) where Empty == ComponentGroup {
        self.init(items, content: content, emptyComponent: { Paragraph(emptyText) })
    }

    @ComponentBuilder public var body: Component {
        if items.isEmpty {
            emptyComponent
        } else {
            List(items, content: content).listStyle(.ordered)
        }
    }
}

public struct UnorderedList<Items: Collection, Content: Component, Empty: Component>: Component {
    public var items: Items
    @ComponentBuilder public var content: (Items.Element) -> Content
    public var emptyComponent: Empty

    public init(_ items: Items, @ComponentBuilder content: @escaping (Items.Element) -> Content, @ComponentBuilder emptyComponent: () -> Empty) {
        self.items = items
        self.content = content
        self.emptyComponent = emptyComponent()
    }

    public init(_ items: Items, emptyText: String, @ComponentBuilder content: @escaping (Items.Element) -> Content) where Empty == ComponentGroup {
        self.init(items, content: content, emptyComponent: { Paragraph(emptyText) })
    }

    @ComponentBuilder public var body: Component {
        if items.isEmpty {
            emptyComponent
        } else {
            List(items, content: content).listStyle(.unordered)
        }
    }
}
