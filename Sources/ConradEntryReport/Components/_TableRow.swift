//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Plot

/// A `Plot.TableRow` replacement that only wraps non-`td` and non-`th` elements with `<td>` tags.
public struct _TableRow: ComponentContainer {
    /// A closure that provides the components that the row should contain.
    @ComponentBuilder var content: ContentProvider

    public init(@ComponentBuilder content: @escaping ContentProvider) {
        self.content = content
    }

    public var body: Component {
        Node.tr(.forEach(content()) {
            .component(wrap($0))
        })
    }

    private func wrap(_ component: Component) -> Component {
        // Check to see if we actually need to do any wrapping.
        guard !(component is TableCell || component is TableHeaderCell) else { return component }
        return Node.td(.component(component))
    }
}
