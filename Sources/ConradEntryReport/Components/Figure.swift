//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

// MARK: Figure

public struct Figure {
    public var image: Image
    public var timestamp: Date?
    public var comment: String?

    public init(image: Image, timestamp: Date? = nil, comment: String? = nil) {
        self.image = image
        self.timestamp = timestamp
        self.comment = comment
    }

    public init(source: URL, altText: String? = nil, timestamp: Date? = nil, comment: String? = nil) {
        self.init(image: Image(source: source, altText: altText ?? comment), timestamp: timestamp, comment: comment)
    }
}

// MARK: - HTMLComponent

extension Figure: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let figureElement = HTMLElement(.figure, "")

        let imgElement = try image.htmlNode(context: context)
        try figureElement.appendChild(imgElement)

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
