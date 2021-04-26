//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

extension Sequence {
    /// Returns an array containing the non-`nil` elements of this sequence.
    ///
    /// Equivalent of calling `compactMap { $0 }`
    ///
    /// - Returns: An array of the non-`nil` elements of the sequence.
    @inline(__always)
    func compacting<Value>() -> [Value] where Element == Value? { compactMap { $0 } }
}
