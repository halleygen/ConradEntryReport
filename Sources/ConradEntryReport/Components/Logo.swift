//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Foundation
import Plot

public struct Logo: Component, Codable {
    public var url: URL?
    public var text: String?

    @ComponentBuilder
    public var body: Component {
        ComponentGroup {
            switch (url, text) {
            case let (url?, text?):
                Div {
                    image(for: url)
                    Text(text)
                }

            case let (url?, nil):
                image(for: url)

            case let (nil, text?):
                Text(text)

            case (nil, nil):
                EmptyComponent()
            }
        }
        .style("display: flex")
        .class("logo")
    }

    @ComponentBuilder
    private func image(for url: URL) -> Component {
        Image(url: url.relativePath, description: "logo")
            .style("height: 2.5em; width: 2.5em")
    }
}

public extension Logo {
    init(relativeImageURL url: URL, text: String) {
        self.init(url: url, text: text)
    }

    init(relativeImageURL url: URL) {
        self.init(url: url, text: nil)
    }

    init(text: String) {
        self.init(url: nil, text: text)
    }
}
