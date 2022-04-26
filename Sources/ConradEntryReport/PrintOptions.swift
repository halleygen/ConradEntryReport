//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Foundation

public struct PrintOptions: Codable {
    public var pageSize: PageSize
    public var pageOrientation: PageOrientation
    public var pageMargins: PageMargins
    public var header: Header
    public var footer: Footer

    public init(pageSize: PageSize = .a4, pageOrientation: PageOrientation = .portrait, pageMargins: PageMargins = .default, header: Header = Header(logo: Logo(text: "Conrad Partners")), footer: Footer = Footer(pageCounter: .currentAndTotal, copyright: "© Conrad Partners Ltd.")) {
        self.pageSize = pageSize
        self.pageMargins = pageMargins
        self.pageOrientation = pageOrientation
        self.header = header
        self.footer = footer
    }

    func serialised() -> String {
        var string = "@page {"
        string.append("size: \(pageSize) \(pageOrientation);\n")
        string.append("margin: \(pageMargins);\n")

        string.append("@top-left { content: element(logo); }")
        if header.showsSectionTitles {
            string.append("@top-right { content: string(section-title); }")
        }

        string.append("@bottom-left {\n")
        string.append("content: \"\(footer.copyright)\";\n")
        string.append("}")

        if let pageCounter = footer.pageCounter {
            string.append("@bottom-right {\n")
            string.append("content: \(pageCounter);\n")
            string.append("}")
        }

        string.append("}")
        return string
    }
}

// MARK: - Page Styles

public extension PrintOptions {
    struct PageSize: CustomStringConvertible, Codable {
        public let description: String

        init(_ description: String) {
            self.description = description
        }

        public static let a4 = PageSize("A4")
        public static let americanLetter = PageSize("letter")

        public static func custom(widthCentimetres: Double, heightCentimetres: Double) -> PageSize {
            PageSize("\(widthCentimetres)cm \(heightCentimetres)cm")
        }

        public static func custom(width: Measurement<UnitLength>, height: Measurement<UnitLength>) -> PageSize {
            custom(widthCentimetres: width.converted(to: .centimeters).value, heightCentimetres: height.converted(to: .centimeters).value)
        }
    }

    enum PageOrientation: String, CustomStringConvertible, Codable {
        case portrait, landscape
        public var description: String { rawValue }
    }

    struct PageMargins: CustomStringConvertible, Codable {
        let verticalCentimetres: Double
        let horizontalCentimetres: Double

        public var description: String { "\(verticalCentimetres)cm \(horizontalCentimetres)cm" }

        public static let `default` = PageMargins(verticalCentimetres: 2.54, horizontalCentimetres: 2.54)
        public static let narrow = PageMargins(verticalCentimetres: 2.54, horizontalCentimetres: 1.91)

        public static func custom(topBottom: Measurement<UnitLength>, leadingTrailing: Measurement<UnitLength>) -> PageMargins {
            PageMargins(verticalCentimetres: topBottom.converted(to: .centimeters).value, horizontalCentimetres: leadingTrailing.converted(to: .centimeters).value)
        }
    }
}

// MARK: - Header

public extension PrintOptions {
    struct Header: Codable {
        public var showsSectionTitles: Bool
        public var logo: Logo?

        public init(logo: Logo? = nil, showsSectionTitles: Bool = true) {
            self.logo = logo
            self.showsSectionTitles = showsSectionTitles
        }
    }
}

// MARK: - Footer

public extension PrintOptions {
    struct Footer: Codable {
        public enum PageCounter: String, CustomStringConvertible, Codable {
            case current = "counter(page)"
            case currentAndTotal = #""Page " counter(page) " / " counter(pages)"#
            public var description: String { rawValue }
        }

        public let pageCounter: PageCounter?
        public let copyright: String

        public init(pageCounter: PageCounter? = .currentAndTotal, copyright: String) {
            self.pageCounter = pageCounter
            self.copyright = copyright
        }
    }
}
