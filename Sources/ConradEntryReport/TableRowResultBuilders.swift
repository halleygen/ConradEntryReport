//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
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
    static func buildFinalResult(_ component: [Columns]) -> [_TableRow]
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

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { column in
            _TableRow {
                column
            }
        }
    }
}

@resultBuilder
public enum SingleColumnWithHeaderTableRowBuilder: TableRowBuilder {
    public typealias Columns = (TableHeaderCell, ChildColumns)
    public typealias ChildColumns = TableCell

    public static func buildExpression<A: HTMLTextConvertible, B: HTMLTextConvertible>(_ expression: (A, B)) -> [Columns] {
        [(TableHeaderCell(expression.0), TableCell(expression.1))]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { header, childColumn in
            _TableRow {
                header
                childColumn
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

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { column in
            _TableRow {
                column.0
                column.1
            }
        }
    }
}

@resultBuilder
public enum DoubleColumnWithHeaderTableRowBuilder: TableRowBuilder {
    public typealias Columns = (TableHeaderCell, ChildColumns)
    public typealias ChildColumns = (TableCell, TableCell)

    public static func buildExpression<A: HTMLTextConvertible, B: HTMLTextConvertible, C: HTMLTextConvertible>(_ expression: (A, (B, C))) -> [Columns] {
        [(TableHeaderCell(expression.0), (TableCell(expression.1.0), TableCell(expression.1.1)))]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { header, childColumns in
            _TableRow {
                header
                childColumns.0
                childColumns.1
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

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { column in
            _TableRow {
                column.0
                column.1
                column.2
            }
        }
    }
}

@resultBuilder
public enum TripleColumnWithHeaderTableRowBuilder: TableRowBuilder {
    public typealias Columns = (TableHeaderCell, ChildColumns)
    public typealias ChildColumns = (TableCell, TableCell, TableCell)

    public static func buildExpression<A: HTMLTextConvertible, B: HTMLTextConvertible, C: HTMLTextConvertible, D: HTMLTextConvertible>(_ expression: (A, (B, C, D))) -> [Columns] {
        [(TableHeaderCell(expression.0), (TableCell(expression.1.0), TableCell(expression.1.1), TableCell(expression.1.2)))]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { header, childColumns in
            _TableRow {
                header
                childColumns.0
                childColumns.1
                childColumns.2
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

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { column in
            _TableRow {
                column.0
                column.1
                column.2
                column.3
            }
        }
    }
}

@resultBuilder
public enum QuadrupleColumnWithHeaderTableRowBuilder: TableRowBuilder {
    public typealias Columns = (TableHeaderCell, ChildColumns)
    public typealias ChildColumns = (TableCell, TableCell, TableCell, TableCell)

    public static func buildExpression<A: HTMLTextConvertible, B: HTMLTextConvertible, C: HTMLTextConvertible, D: HTMLTextConvertible, E: HTMLTextConvertible>(_ expression: (A, (B, C, D, E))) -> [Columns] {
        [(TableHeaderCell(expression.0), (TableCell(expression.1.0), TableCell(expression.1.1), TableCell(expression.1.2), TableCell(expression.1.3)))]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { header, childColumns in
            _TableRow {
                header
                childColumns.0
                childColumns.1
                childColumns.2
                childColumns.3
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

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { column in
            _TableRow {
                column.0
                column.1
                column.2
                column.3
                column.4
            }
        }
    }
}

@resultBuilder
public enum QuintupleColumnWithHeaderTableRowBuilder: TableRowBuilder {
    public typealias Columns = (TableHeaderCell, ChildColumns)
    public typealias ChildColumns = (TableCell, TableCell, TableCell, TableCell, TableCell)

    public static func buildExpression<A: HTMLTextConvertible, B: HTMLTextConvertible, C: HTMLTextConvertible, D: HTMLTextConvertible, E: HTMLTextConvertible, F: HTMLTextConvertible>(_ expression: (A, (B, C, D, E, F))) -> [Columns] {
        [(TableHeaderCell(expression.0), (TableCell(expression.1.0), TableCell(expression.1.1), TableCell(expression.1.2), TableCell(expression.1.3), TableCell(expression.1.4)))]
    }

    public static func buildFinalResult(_ component: [Columns]) -> [_TableRow] {
        component.map { header, childColumns in
            _TableRow {
                header
                childColumns.0
                childColumns.1
                childColumns.2
                childColumns.3
                childColumns.4
            }
        }
    }
}
