//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

struct FontFace {
    let family: String
    let source: URL
    let format: Format
    let weight: Weight
    let style: Style

    init(family: String, source: URL, format: FontFace.Format = .trueType, weight: FontFace.Weight, style: FontFace.Style) {
        self.family = family
        self.source = source
        self.format = format
        self.weight = weight
        self.style = style
    }

    func serialize() throws -> String {
        guard try source.checkResourceIsReachable() else {
            throw Styles.Error.missingResource(source)
        }

        var string = "@font-face{"
        string.append("font-family:\"\(family)\";")
        string.append("font-style:\(style.rawValue);")
        string.append("font-weight:\(weight.rawValue);")
        string.append("src:url(\(source.absoluteString)) format(\(format.rawValue));")
        string.append("}")
        return string
    }
}

extension FontFace {
    enum Format: String {
        case trueType = "truetype"
    }

    enum Style: String {
        case normal, italic
    }

    struct Weight: RawRepresentable {
        let rawValue: Int

        static let normal = Weight(rawValue: 400)
        static let bold = Weight(rawValue: 700)
    }
}
