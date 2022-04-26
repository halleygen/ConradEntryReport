//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Plot

public struct OrderedList<Items: Sequence, Content: Component>: Component {
    public var items: Items
    @ComponentBuilder public var content: (Items.Element) -> Content

    public init(_ items: Items, @ComponentBuilder content: @escaping (Items.Element) -> Content) {
        self.items = items
        self.content = content
    }

    public var body: Component {
        List(items, content: content).listStyle(.ordered)
    }
}

public struct UnorderedList<Items: Sequence, Content: Component>: Component {
    public var items: Items
    @ComponentBuilder public var content: (Items.Element) -> Content

    public init(_ items: Items, @ComponentBuilder content: @escaping (Items.Element) -> Content) {
        self.items = items
        self.content = content
    }

    public var body: Component {
        List(items, content: content).listStyle(.unordered)
    }
}
