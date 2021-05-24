//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

struct FontFamily {
    let name: String
    let faces: [FontFace]

    private init(name: String, faces: [FontFace]) {
        assert(faces.allSatisfy { $0.family == name })
        self.name = name
        self.faces = faces
    }
}

// MARK: - Open Sans

extension FontFamily {
    static var openSans: FontFamily {
        FontFamily(name: "Open Sans", faces: [
            FontFace(
                family: "Open Sans",
                source: Bundle.module.url(forResource: "OpenSans-Regular", withExtension: "ttf")!,
                weight: .normal,
                style: .normal
            ),
            FontFace(
                family: "Open Sans",
                source: Bundle.module.url(forResource: "OpenSans-Bold", withExtension: "ttf")!,
                weight: .bold,
                style: .normal
            ),
            FontFace(
                family: "Open Sans",
                source: Bundle.module.url(forResource: "OpenSans-Italic", withExtension: "ttf")!,
                weight: .normal,
                style: .italic
            ),
            FontFace(
                family: "Open Sans",
                source: Bundle.module.url(forResource: "OpenSans-BoldItalic", withExtension: "ttf")!,
                weight: .bold,
                style: .italic
            )
        ])
    }
}

// MARK: - Roboto

extension FontFamily {
    static var roboto: FontFamily {
        FontFamily(name: "Roboto", faces: [
            FontFace(
                family: "Roboto",
                source: Bundle.module.url(forResource: "Roboto-Regular", withExtension: "ttf")!,
                weight: .normal,
                style: .normal
            ),
            FontFace(
                family: "Roboto",
                source: Bundle.module.url(forResource: "Roboto-Bold", withExtension: "ttf")!,
                weight: .bold,
                style: .normal
            ),
            FontFace(
                family: "Roboto",
                source: Bundle.module.url(forResource: "Roboto-Italic", withExtension: "ttf")!,
                weight: .normal,
                style: .italic
            ),
            FontFace(
                family: "Roboto",
                source: Bundle.module.url(forResource: "Roboto-BoldItalic", withExtension: "ttf")!,
                weight: .bold,
                style: .italic
            )
        ])
    }
}
