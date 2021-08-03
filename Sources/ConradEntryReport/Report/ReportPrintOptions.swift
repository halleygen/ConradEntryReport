//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public extension Report {
    struct PrintOptions {
        public let pageSize: PageSize
        public let pageOrientation: PageOrientation
        public let pageMargins: PageMargins

        public init(pageSize: PageSize = .a4, pageOrientation: PageOrientation = .portrait, pageMargins: PageMargins = .default) {
            self.pageSize = pageSize
            self.pageMargins = pageMargins
            self.pageOrientation = pageOrientation
        }
    }
}

// MARK: - Page Styles

public extension Report.PrintOptions {
    struct PageSize: CustomStringConvertible {
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

    enum PageOrientation: String, CustomStringConvertible {
        case portrait, landscape
        public var description: String { rawValue }
    }

    struct PageMargins: CustomStringConvertible {
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
