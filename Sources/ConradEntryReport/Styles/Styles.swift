//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public struct Styles {
    private static var baseURL: URL { Bundle.module.url(forResource: "styles", withExtension: "css")! }

    let bodyFontFamily: FontFamily
    let headingFontFamily: FontFamily
    let pageRules: KeyValuePairs<String, String>

    public static var `default`: Styles { Styles(bodyFontFamily: .openSans, headingFontFamily: .roboto, pageRules: ["size": "A4"]) }

    public func serialize(locale: Locale) throws -> String {
        let base = try String(contentsOf: Self.baseURL)
        let serializedFontFaces = try (bodyFontFamily.faces + headingFontFamily.faces).map { try $0.serialize() }.joined(separator: "\n")
        return """
        \(serializedFontFaces)

        :root { font-family: "\(bodyFontFamily.name)"; }
        h1, h2, h3, h4, h5, h6 { font-family: "\(headingFontFamily.name)"; }
        @page { \(pageRules.map { "\($0): \($1);" }.joined()) }

        \(base)
        """
    }
}

extension Styles {
    enum Error: Swift.Error {
        case missingResource(URL)
    }
}
