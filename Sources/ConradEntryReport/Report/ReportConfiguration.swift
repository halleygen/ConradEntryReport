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
        let node = HTMLTextNode("", nil)

        let styleElement = HTMLElement(.style, "")
        try styleElement.text(try styles.serialize(locale: context.locale))

        let titleElement = HTMLElement(.title, "")
        try titleElement.text(title)

        try node.addChildren(styleElement, titleElement)

        return node
    }
}
