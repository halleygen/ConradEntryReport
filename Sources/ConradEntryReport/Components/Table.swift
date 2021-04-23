//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

// MARK: Table

public struct Table {
    public var title: HTMLTextConvertible?
    public var rows: [[Data]]
    public var columnHeaderMode: ColumnHeaderMode
    public var rowHeaderMode: RowHeaderMode

    public init(title: HTMLTextConvertible?, columnHeaderMode: ColumnHeaderMode = .firstRowOfTable, rowHeaderMode: RowHeaderMode = .firstColumnOfRow, rows: [[Data]]) {
        self.title = title
        self.rows = rows
        self.columnHeaderMode = columnHeaderMode
        self.rowHeaderMode = rowHeaderMode
    }

    @_disfavoredOverload
    public init(title: HTMLTextConvertible?, columnHeaderMode: ColumnHeaderMode = .firstRowOfTable, rowHeaderMode: RowHeaderMode = .firstColumnOfRow, rows: [[HTMLTextConvertible?]]) {
        let mapped = rows.map { row -> [Data] in
            row.map { Data($0) }
        }
        self.init(title: title, columnHeaderMode: columnHeaderMode, rowHeaderMode: rowHeaderMode, rows: mapped)
    }

    public enum ColumnHeaderMode {
        case none, firstRowOfTable
    }

    public enum RowHeaderMode {
        case none, firstColumnOfRow
    }

    public struct Data {
        public var value: HTMLTextConvertible?
        public var columnSpan: Int

        public init(_ value: HTMLTextConvertible?, columnSpan: Int = 1) {
            self.value = value
            self.columnSpan = columnSpan
        }

        func htmlString(context: Report.Context) -> String {
            value?.htmlString(context: context) ?? ""
        }

        public static let empty: Data = .init(nil)
    }

    public enum Error: Swift.Error {
        case emptyTable
        case inconsistentRowLengths([[Data]])
    }
}

// MARK: - HTMLComponent

extension Table: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        guard !rows.isEmpty, rows.allSatisfy({ !$0.isEmpty }) else { throw Error.emptyTable }
        guard tableIsValid() else { throw Error.inconsistentRowLengths(rows) }

        let tableElement = HTMLElement(.table, "")

        if let title = title {
            let captionElement = try tableElement.appendElement(.caption)
            let titleElement = try H4(Text(title)).htmlNode(context: context)
            try captionElement.appendChild(titleElement)
        }

        let tableBodyRows: [[Data]]
        switch columnHeaderMode {
        case .none:
            tableBodyRows = rows

        case .firstRowOfTable:
            let tableHeaderElement = try tableHeaderElement(for: rows[0], context: context)
            try tableElement.appendChild(tableHeaderElement)

            tableBodyRows = Array(rows.dropFirst())
        }

        let bodyElement = try tableElement.appendElement(.tableBody)

        for row in tableBodyRows {
            let rowElement = try bodyElement.appendElement(.tableRow)

            for (columnIndex, data) in row.enumerated() {
                let dataElement: HTMLElement
                switch rowHeaderMode {
                case .none:
                    dataElement = try rowElement.appendElement(.tableDataCell)

                case .firstColumnOfRow:
                    if columnIndex == 0 {
                        dataElement = try rowElement.appendElement(.tableHeaderCell)
                        try dataElement.attr("scope", "row")
                    } else {
                        dataElement = try rowElement.appendElement(.tableDataCell)
                    }
                }

                try dataElement.text(data.htmlString(context: context))
                if data.columnSpan > 1 {
                    try dataElement.attr("colspan", String(data.columnSpan))
                }
            }
        }

        return tableElement
    }

    private func tableHeaderElement(for row: [Data], context: Report.Context) throws -> HTMLElement {
        let tableHeader = HTMLElement(.tableHeader, "")
        let headerRow = try tableHeader.appendElement(.tableRow)

        for data in row {
            let cellElement = try headerRow.appendElement(.tableHeaderCell)
            try cellElement.text(data.htmlString(context: context))

            if data.columnSpan > 1 {
                try cellElement.attr("colspan", String(data.columnSpan))
            }
        }

        return tableHeader
    }

    private func tableIsValid() -> Bool {
        zip(rows, rows.dropFirst())
            .allSatisfy { first, second -> Bool in
                // Check that all rows are the same length by examing the column span of each piece of data
                first.reduce(0) { $0 + max(1, $1.columnSpan) } == second.reduce(0) { $0 + max(1, $1.columnSpan) }
            }
    }
}

// MARK: - Helpers

public extension Table {
    static func twoColumns(title: HTMLTextConvertible?, columnHeaderMode: ColumnHeaderMode = .firstRowOfTable, rowHeaderMode: RowHeaderMode = .firstColumnOfRow, rows: [(HTMLTextConvertible?, HTMLTextConvertible?)]) -> Table {
        Self(title: title, columnHeaderMode: columnHeaderMode, rowHeaderMode: rowHeaderMode, rows: rows.map { [$0.0, $0.1] })
    }

    static func threeColumns(title: HTMLTextConvertible?, columnHeaderMode: ColumnHeaderMode = .firstRowOfTable, rowHeaderMode: RowHeaderMode = .firstColumnOfRow, rows: [(HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?)]) -> Table {
        Self(title: title, columnHeaderMode: columnHeaderMode, rowHeaderMode: rowHeaderMode, rows: rows.map { [$0.0, $0.1, $0.2] })
    }

    static func fourColumns(title: HTMLTextConvertible?, columnHeaderMode: ColumnHeaderMode = .firstRowOfTable, rowHeaderMode: RowHeaderMode = .firstColumnOfRow, rows: [(HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?)]) -> Table {
        Self(title: title, columnHeaderMode: columnHeaderMode, rowHeaderMode: rowHeaderMode, rows: rows.map { [$0.0, $0.1, $0.2, $0.3] })
    }

    static func fiveColumns(title: HTMLTextConvertible?, columnHeaderMode: ColumnHeaderMode = .firstRowOfTable, rowHeaderMode: RowHeaderMode = .firstColumnOfRow, rows: [(HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?)]) -> Table {
        Self(title: title, columnHeaderMode: columnHeaderMode, rowHeaderMode: rowHeaderMode, rows: rows.map { [$0.0, $0.1, $0.2, $0.3, $0.4] })
    }

    static func sixColumns(title: HTMLTextConvertible?, columnHeaderMode: ColumnHeaderMode = .firstRowOfTable, rowHeaderMode: RowHeaderMode = .firstColumnOfRow, rows: [(HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?, HTMLTextConvertible?)]) -> Table {
        Self(title: title, columnHeaderMode: columnHeaderMode, rowHeaderMode: rowHeaderMode, rows: rows.map { [$0.0, $0.1, $0.2, $0.3, $0.4, $0.5] })
    }
}
