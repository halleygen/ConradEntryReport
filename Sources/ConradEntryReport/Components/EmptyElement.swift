//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public struct EmptyComponent: HTMLComponent {
    func htmlElement(context: Report.Context) throws -> HTMLElement {
        let element = HTMLElement(.division, "")
        try element.attr("hidden", true)
        return element
    }
}
