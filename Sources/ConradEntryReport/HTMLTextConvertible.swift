//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

// MARK: - HTMLTextConvertible

public protocol HTMLTextConvertible {
    static var nilString: String { get }
    func htmlString(context: Context) -> String
}

public extension HTMLTextConvertible {
    static var nilString: String { "n/a" }
}

// MARK: - Implementations

// MARK: Bool

extension Bool: HTMLTextConvertible {
    public func htmlString(context: Context) -> String {
        self ? "Yes" : "No"
    }
}

// MARK: String

extension String: HTMLTextConvertible {
    public func htmlString(context: Context) -> String { self }
}

// MARK: Integers

public extension HTMLTextConvertible where Self: BinaryInteger {
    func htmlString(context: Context) -> String {
        context.localizedString(for: self)
    }
}

extension Int: HTMLTextConvertible {}
extension Int64: HTMLTextConvertible {}

// MARK: Floating Points

public extension HTMLTextConvertible where Self: BinaryFloatingPoint {
    func htmlString(context: Context) -> String {
        context.localizedString(for: self)
    }
}

extension Double: HTMLTextConvertible {}
extension Float: HTMLTextConvertible {}

// MARK: Collections

extension Array: HTMLTextConvertible where Element: HTMLTextConvertible {
    public func htmlString(context: ConradEntryReport.Context) -> String {
        context.localizedString(for: map { $0.htmlString(context: context) })
    }
}

public extension Collection where Element: HTMLTextConvertible {
    func htmlString(context: Context) -> String {
        map { $0.htmlString(context: context) }.htmlString(context: context)
    }
}

public extension Collection where Element: HTMLTextConvertible & Comparable {
    func htmlString(context: Context) -> String {
        sorted().htmlString(context: context)
    }
}

extension Set: HTMLTextConvertible where Element: HTMLTextConvertible {}
extension ContiguousArray: HTMLTextConvertible where Element: HTMLTextConvertible {}

// MARK: Measurement

extension Measurement: HTMLTextConvertible {
    public func htmlString(context: Context) -> String {
        context.localizedString(for: self)
    }
}
