//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

// MARK: Table

public struct Table {
    public var title: HTMLTextConvertible?
    public var columnTitles: (left: HTMLTextConvertible?, right: HTMLTextConvertible?)
    public var rows: [Row]

    public init(title: HTMLTextConvertible?, columnTitles: (HTMLTextConvertible?, HTMLTextConvertible?) = (nil, nil), rows: [Table.Row]) {
        self.title = title
        self.columnTitles = columnTitles
        self.rows = rows
    }
}

// MARK: - HTMLComponent

extension Table: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        guard !rows.isEmpty else { throw ReportError.emptyTable(self) }

        let tableElement = HTMLElement(.table, "")

        if let title = title {
            let captionElement = try tableElement.appendElement(.caption)
            try captionElement.text(title.htmlString(context: context))
        }

        if let tableHeader = try tableHeaderElement(lhsTitle: columnTitles.left, rhsTitle: columnTitles.right, context: context) {
            try tableElement.appendChild(tableHeader)
        }

        let tableBody = try tableElement.appendElement(.tableBody)
        for row in rows {
            let rowElement = try row.htmlNode(context: context)
            try tableBody.appendChild(rowElement)
        }

        return tableElement
    }

    private func tableHeaderElement(lhsTitle: HTMLTextConvertible?, rhsTitle: HTMLTextConvertible?, context: Report.Context) throws -> HTMLElement? {
        guard lhsTitle != nil, rhsTitle != nil else { return nil }

        let tableHeader = HTMLElement(.tableHeader, "")
        let headerRow = try tableHeader.appendElement(.tableRow)

        let leftHand = try headerRow.appendElement(.tableHeaderCell)
        try leftHand.text(lhsTitle?.htmlString(context: context) ?? "")

        let rightHand = try headerRow.appendElement(.tableHeaderCell)
        try rightHand.text(rhsTitle?.htmlString(context: context) ?? "")

        return tableHeader
    }
}

// MARK: - Row

public extension Table {
    struct Row: HTMLComponent {
        public var title: HTMLTextConvertible
        public var content: HTMLTextConvertible

        public init(title: HTMLTextConvertible, content: HTMLTextConvertible) {
            self.title = title
            self.content = content
        }

        public func htmlNode(context: Report.Context) throws -> HTMLNode {
            let rowElement = HTMLElement(.tableRow, "")

            let titleElement = try rowElement.appendElement(.tableHeaderCell)
            try titleElement.attr("scope", "row")
            try titleElement.text(title.htmlString(context: context))

            let contentElement = try rowElement.appendElement(.tableDataCell)
            try contentElement.text(content.htmlString(context: context))

            return rowElement
        }
    }
}
