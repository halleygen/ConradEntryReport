//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct Logo: HTMLComponent {
    let image: Image
    let text: Text?

    public init(logoURL: URL, text: String?) {
        self.image = Image(source: logoURL, sourceEncodingStrategy: .absoluteURL, altText: "Logo")
        self.text = text.map(Text.init(_:))
    }

    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let imageNode = try image.htmlNode(context: context)
        try imageNode.attr("style", "height: 2.5em; width: 2.5em")

        guard let textNode = try text?.htmlNode(context: context) else {
            return imageNode
        }

        let wrapper = HTMLElement(.division, "")
        try wrapper.addClass("logo")
        try wrapper.attr("style", "display: flex;")
        try wrapper.appendChild(imageNode)
        try wrapper.appendChild(textNode)
        return wrapper
    }
}
