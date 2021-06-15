//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

// MARK: - TableRowBuilder Protocol

protocol TableRowBuilder {
    associatedtype Row

    static func buildBlock(_ components: [Row]...) -> [Row]
    static func buildExpression(_ expression: Row) -> [Row]
    static func buildOptional(_ component: [Row]?) -> [Row]
    static func buildEither(first component: [Row]) -> [Row]
    static func buildEither(second component: [Row]) -> [Row]
    static func buildFinalResult(_ component: [Row]) -> [[Table.Data]]
}

extension TableRowBuilder {
    public static func buildBlock(_ components: [Row]...) -> [Row] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: Row) -> [Row] {
        [expression]
    }

    public static func buildOptional(_ component: [Row]?) -> [Row] {
        if let component = component {
            return component
        } else {
            return []
        }
    }

    public static func buildEither(first component: [Row]) -> [Row] {
        component
    }

    public static func buildEither(second component: [Row]) -> [Row] {
        component
    }
}

// MARK: - SingleColumnTableRowBuilder

@resultBuilder
public enum SingleColumnTableRowBuilder: TableRowBuilder {
    typealias Row = Table.Data

    static func buildExpression(_ expression: HTMLTextConvertible) -> [Table.Data] {
        [Table.Data(expression)]
    }

    static func buildFinalResult(_ component: [Table.Data]) -> [[Table.Data]] {
        [component]
    }
}

// MARK: - DoubleColumnTableRowBuilder

@resultBuilder
public enum DoubleColumnTableRowBuilder: TableRowBuilder {
    public typealias Row = (Table.Data, Table.Data)

    public static func buildExpression(_ expression: (HTMLTextConvertible, HTMLTextConvertible)) -> [Row] {
        [(Table.Data(expression.0), Table.Data(expression.1))]
    }

    public static func buildFinalResult(_ component: [Row]) -> [[Table.Data]] {
        component.map { [$0.0, $0.1] }
    }
}

// MARK: - TripleColumnTableRowBuilder

@resultBuilder
public enum TripleColumnTableRowBuilder: TableRowBuilder {
    public typealias Row = (Table.Data, Table.Data, Table.Data)

    public static func buildExpression(_ expression: (HTMLTextConvertible, HTMLTextConvertible, HTMLTextConvertible)) -> [Row] {
        [(Table.Data(expression.0), Table.Data(expression.1), Table.Data(expression.2))]
    }

    public static func buildFinalResult(_ component: [Row]) -> [[Table.Data]] {
        component.map { [$0.0, $0.1, $0.2] }
    }
}

// MARK: - QuadrupleColumnTableRowBuilder

@resultBuilder
public enum QuadrupleColumnTableRowBuilder: TableRowBuilder {
    public typealias Row = (Table.Data, Table.Data, Table.Data, Table.Data)

    public static func buildExpression(_ expression: (HTMLTextConvertible, HTMLTextConvertible, HTMLTextConvertible, HTMLTextConvertible)) -> [Row] {
        [(Table.Data(expression.0), Table.Data(expression.1), Table.Data(expression.2), Table.Data(expression.3))]
    }

    public static func buildFinalResult(_ component: [Row]) -> [[Table.Data]] {
        component.map { [$0.0, $0.1, $0.2, $0.3] }
    }
}

// MARK: - QuintupleColumnTableRowBuilder

@resultBuilder
public enum QuintupleColumnTableRowBuilder: TableRowBuilder {
    public typealias Row = (Table.Data, Table.Data, Table.Data, Table.Data, Table.Data)

    public static func buildExpression(_ expression: (HTMLTextConvertible, HTMLTextConvertible, HTMLTextConvertible, HTMLTextConvertible, HTMLTextConvertible)) -> [Row] {
        [(Table.Data(expression.0), Table.Data(expression.1), Table.Data(expression.2), Table.Data(expression.3), Table.Data(expression.4))]
    }

    @_disfavoredOverload
    public static func buildExpression(_ expression: (HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?)) -> [Row] {
        [(Table.Data(expression.0), Table.Data(expression.1), Table.Data(expression.2), Table.Data(expression.3), Table.Data(expression.4))]
    }

    public static func buildFinalResult(_ component: [Row]) -> [[Table.Data]] {
        component.map { [$0.0, $0.1, $0.2, $0.3, $0.4] }
    }
}

// MARK: - VariableColumnTableRowBuilder

@resultBuilder
public enum VariableColumnTableRowBuilder: TableRowBuilder {
    public typealias Row = [Table.Data]

    public static func buildExpression(_ expression: HTMLTextConvertible) -> [Row] {
        [[Table.Data(expression)]]
    }

    public static func buildFinalResult(_ component: [Row]) -> [[Table.Data]] {
        component
    }
}
