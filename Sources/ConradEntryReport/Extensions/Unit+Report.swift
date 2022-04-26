//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Foundation

public extension UnitMass {
    static let wetMetricTonnes = UnitMass(symbol: "WMT", converter: UnitConverterLinear(coefficient: 1_000))
    static let dryMetricTonnes = UnitMass(symbol: "DMT", converter: UnitConverterLinear(coefficient: 1_000))
}

public final class UnitDischargeRate: Dimension {
    public static let wetMetricTonnesPerHour = UnitDischargeRate(symbol: "WMT/hr", converter: UnitConverterLinear(coefficient: 1))
    public static let dryMetricTonnesPerHour = UnitDischargeRate(symbol: "DMT/hr", converter: UnitConverterLinear(coefficient: 1))

    public static let wetMetricTonnesPerDay = UnitDischargeRate(symbol: "WMT/day", converter: UnitConverterLinear(coefficient: 24))
    public static let dryMetricTonnesPerDay = UnitDischargeRate(symbol: "DMT/day", converter: UnitConverterLinear(coefficient: 24))
}

public final class UnitScreenAperture: Unit {
    public static let micron = UnitScreenAperture(symbol: "micron")
    public static let millimetre = UnitScreenAperture(symbol: "mm")
}
