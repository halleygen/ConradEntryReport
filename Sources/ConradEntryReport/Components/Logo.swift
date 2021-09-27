//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation
import Plot

public struct Logo: Component {
    public var url: URL
    public var text: String?

    public init(url: URL, text: String? = nil) {
        self.url = url
        self.text = text
    }

    @ComponentBuilder
    public var body: Component {
        if let text = text {
            Div {
                image
                Text(text)
            }
            .style("display: flex")
            .class("logo")
        } else {
            image
                .class("logo")
        }
    }

    private var image: Component {
        Image(url: url, description: "logo")
            .style("height: 2.5em; width: 2.5em")
    }
}
