//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

extension Calendar.Component {
    static func from(_ units: NSCalendar.Unit) -> Set<Calendar.Component> {
        var components = Set<Calendar.Component>()

        if units.contains(.year) {
            components.insert(.year)
        }

        if units.contains(.month) {
            components.insert(.month)
        }

        if units.contains(.weekOfMonth) {
            components.insert(.weekOfMonth)
        }

        if units.contains(.day) {
            components.insert(.day)
        }

        if units.contains(.hour) {
            components.insert(.hour)
        }

        if units.contains(.minute) {
            components.insert(.minute)
        }

        if units.contains(.second) {
            components.insert(.second)
        }

        return components
    }
}

extension NSCalendar.Unit: Hashable {}
