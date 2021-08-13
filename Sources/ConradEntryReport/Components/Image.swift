//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct Image: HTMLComponent {
    public var source: URL
    public var sourceEncodingStrategy: SourceEncodingStrategy
    public var altText: String?

    public init(source: URL, sourceEncodingStrategy: SourceEncodingStrategy = .relativePath, altText: String? = nil) {
        self.source = source
        self.altText = altText
        self.sourceEncodingStrategy = sourceEncodingStrategy
    }

    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let imageElement = HTMLElement(.image, "")
        try imageElement.attr("src", sourceEncodingStrategy(source))

        if let altText = altText {
            try imageElement.attr("alt", altText)
        }
        return imageElement
    }

    public struct SourceEncodingStrategy {
        private let transform: (URL) -> String

        public static let relativePath = SourceEncodingStrategy(transform: { $0.relativePath })
        public static let absoluteURL = SourceEncodingStrategy(transform: { $0.absoluteString })

        fileprivate func callAsFunction(_ url: URL) -> String { transform(url) }
    }
}
