//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public struct EmptyComponent: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let element = HTMLElement(.division, "")
        try element.attr("hidden", true)
        return element
    }
}
