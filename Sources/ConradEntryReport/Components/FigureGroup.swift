//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public struct FigureGroup {
    @usableFromInline
    var figures: ContiguousArray<Figure>

    public init(_ figures: ContiguousArray<Figure>) {
        self.figures = figures
    }
}

// MARK: - HTMLComponent

extension FigureGroup: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        guard figures.count > 1 else {
            if let first = figures.first {
                return try first.htmlNode(context: context)
            } else {
                return try EmptyComponent().htmlNode(context: context)
            }
        }

        let groupDiv = HTMLElement(.division, "")

        for figure in figures {
            let rowDiv = try groupDiv.appendElement(.division)
            let figureElement = try figure.htmlNode(context: context)
            try rowDiv.appendChild(figureElement)
        }

        return groupDiv
    }
}

// MARK: - RandomAccessCollection

extension FigureGroup: RandomAccessCollection {
    public typealias Element = ContiguousArray<Figure>.Element
    public typealias Index = ContiguousArray<Figure>.Index

    public subscript(position: ContiguousArray<Figure>.Index) -> ContiguousArray<Figure>.Element {
        _read { yield figures[position] }
        _modify { yield &figures[position] }
        set { figures[position] = newValue }
    }

    @inlinable
    public var startIndex: ContiguousArray<Figure>.Index { figures.startIndex }

    @inlinable
    public var endIndex: ContiguousArray<Figure>.Index { figures.endIndex }
}
