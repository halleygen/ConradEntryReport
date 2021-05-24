//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public extension Report {
    struct Configuration {
        public var title: String
        public var styles: Styles

        public init(title: String, styles: Styles = .default) {
            self.title = title
            self.styles = styles
        }
    }
}

extension Report.Configuration: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let head = HTMLElement(.head, "")

        let styleElement = try head.appendElement(.style)
        try styleElement.text(try styles.serialize(locale: context.locale))

        let titleElement = try head.appendElement(.title)
        try titleElement.text(title)

        return head
    }
}
