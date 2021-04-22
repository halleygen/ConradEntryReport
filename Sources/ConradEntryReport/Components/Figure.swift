//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

// MARK: Figure

public struct Figure {
    public var source: URL
    public var altText: String?
    public var timestamp: Date?
    public var comment: String?

    public init(source: URL, altText: String?, timestamp: Date?, comment: String?) {
        self.source = source
        self.altText = altText ?? comment
        self.timestamp = timestamp
        self.comment = comment
    }
}

// MARK: - HTMLComponent

extension Figure: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let figureElement = HTMLElement(.figure, "")

        let imgElement = try figureElement.appendElement(.image)
        try imgElement.attr("src", source.absoluteString)

        if let altText = altText {
            try imgElement.attr("alt", altText)
        }

        switch (timestamp, comment) {
        case let (.some(timestamp), .some(comment)):
            let caption = try figureElement.appendElement(.figureCaption)
            try caption.text("\(comment) (\(context.localizedString(for: timestamp)))")

        case let (.some(timestamp), .none):
            let caption = try figureElement.appendElement(.figureCaption)
            try caption.text(context.localizedString(for: timestamp))

        case let (.none, .some(comment)):
            let caption = try figureElement.appendElement(.figureCaption)
            try caption.text(comment)

        case (.none, .none):
            break
        }

        return figureElement
    }
}
