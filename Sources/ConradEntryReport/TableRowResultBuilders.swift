//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Plot

// MARK: - TableRowBuilder Protocol

public protocol TableRowBuilder {
    associatedtype Columns

    static func buildBlock(_ components: [Columns]...) -> [Columns]
    static func buildExpression(_ expression: Columns) -> [Columns]
    static func buildExpression(_ expression: Columns?) -> [Columns]
    static func buildOptional(_ component: [Columns]?) -> [Columns]
    static func buildEither(first component: [Columns]) -> [Columns]
    static func buildEither(second component: [Columns]) -> [Columns]
    static func buildFinalResult(_ component: [Columns]) -> [TableRow]
}

public extension TableRowBuilder {
    static func buildBlock(_ components: [Columns]...) -> [Columns] {
        components.flatMap { $0 }
    }

    static func buildExpression(_ expression: Columns) -> [Columns] {
        [expression]
    }

    static func buildExpression(_ expression: Columns?) -> [Columns] {
        if let expression = expression {
            return [expression]
        } else {
            return []
        }
    }

    static func buildOptional(_ component: [Columns]?) -> [Columns] {
        if let component = component {
            return component
        } else {
            return []
        }
    }

    static func buildEither(first component: [Columns]) -> [Columns] {
        component
    }

    static func buildEither(second component: [Columns]) -> [Columns] {
        component
    }
}

// MARK: - SingleColumnTableRowBuilder

@resultBuilder
public enum SingleColumnTableRowBuilder: TableRowBuilder {
    public typealias Columns = TableCell

    public static func buildExpression<T: HTMLTextConvertible>(_ expression: T) -> [Columns] {
        [TableCell(expression)]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [TableRow] {
        component.map { column in
            TableRow {
                column
            }
        }
    }
}

// MARK: - DoubleColumnTableRowBuilder

@resultBuilder
public enum DoubleColumnTableRowBuilder: TableRowBuilder {
    public typealias Columns = (TableCell, TableCell)

    public static func buildExpression<A: HTMLTextConvertible, B: HTMLTextConvertible>(_ expression: (A, B)) -> [Columns] {
        [(TableCell(expression.0), TableCell(expression.1))]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [TableRow] {
        component.map { column in
            TableRow {
                column.0
                column.1
            }
        }
    }
}

// MARK: - TripleColumnTableRowBuilder

@resultBuilder
public enum TripleColumnTableRowBuilder: TableRowBuilder {
    public typealias Columns = (TableCell, TableCell, TableCell)

    public static func buildExpression<A: HTMLTextConvertible, B: HTMLTextConvertible, C: HTMLTextConvertible>(_ expression: (A, B, C)) -> [Columns] {
        [(TableCell(expression.0), TableCell(expression.1), TableCell(expression.2))]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [TableRow] {
        component.map { column in
            TableRow {
                column.0
                column.1
                column.2
            }
        }
    }
}

// MARK: - QuadrupleColumnTableRowBuilder

@resultBuilder
public enum QuadrupleColumnTableRowBuilder: TableRowBuilder {
    public typealias Columns = (TableCell, TableCell, TableCell, TableCell)

    public static func buildExpression<A: HTMLTextConvertible, B: HTMLTextConvertible, C: HTMLTextConvertible, D: HTMLTextConvertible>(_ expression: (A, B, C, D)) -> [Columns] {
        [(TableCell(expression.0), TableCell(expression.1), TableCell(expression.2), TableCell(expression.3))]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [TableRow] {
        component.map { column in
            TableRow {
                column.0
                column.1
                column.2
                column.3
            }
        }
    }
}

// MARK: - QuintupleColumnTableRowBuilder

@resultBuilder
public enum QuintupleColumnTableRowBuilder: TableRowBuilder {
    public typealias Columns = (TableCell, TableCell, TableCell, TableCell, TableCell)

    public static func buildExpression<A: HTMLTextConvertible, B: HTMLTextConvertible, C: HTMLTextConvertible, D: HTMLTextConvertible, E: HTMLTextConvertible>(_ expression: (A, B, C, D, E)) -> [Columns] {
        [(TableCell(expression.0), TableCell(expression.1), TableCell(expression.2), TableCell(expression.3), TableCell(expression.4))]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [TableRow] {
        component.map { column in
            TableRow {
                column.0
                column.1
                column.2
                column.3
                column.4
            }
        }
    }
}
