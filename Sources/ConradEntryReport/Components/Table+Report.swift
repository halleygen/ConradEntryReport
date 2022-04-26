//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Plot

public extension Table {
    // MARK: - Single

    init(header: String? = nil, footer: String? = nil, caption: String? = nil, @SingleColumnTableRowBuilder rows: @escaping () -> [_TableRow]) {
        self.init(
            caption: caption.map(TableCaption.init(_:)),
            header: header.map { h in
                TableRow {
                    Text(h)
                }
            }, footer: footer.map { f in
                TableRow {
                    Text(f)
                }
            }, rows: {
                for row in rows() {
                    row
                }
            }
        )
    }

    @_disfavoredOverload
    init(tableHeader header: (String, String)? = nil, tableFooter footer: (String, String)? = nil, caption: String? = nil, @SingleColumnWithHeaderTableRowBuilder rowsWithHeader rows: @escaping () -> [_TableRow]) {
        self.init(header: header, footer: footer, caption: caption, rows: rows)
    }

    // MARK: - Double

    init(header: (String, String)? = nil, footer: (String, String)? = nil, caption: String? = nil, @DoubleColumnTableRowBuilder rows: @escaping () -> [_TableRow]) {
        self.init(
            caption: caption.map(TableCaption.init(_:)),
            header: header.map { h in
                TableRow {
                    Text(h.0)
                    Text(h.1)
                }
            }, footer: footer.map { f in
                TableRow {
                    Text(f.0)
                    Text(f.1)
                }
            }, rows: {
                for row in rows() {
                    row
                }
            }
        )
    }

    init(tableHeader header: (String, String, String)? = nil, tableFooter footer: (String, String, String)? = nil, caption: String? = nil, @DoubleColumnWithHeaderTableRowBuilder rowsWithHeader rows: @escaping () -> [_TableRow]) {
        self.init(header: header, footer: footer, caption: caption, rows: rows)
    }

    // MARK: - Triple

    init(header: (String, String, String)? = nil, footer: (String, String, String)? = nil, caption: String? = nil, @TripleColumnTableRowBuilder rows: @escaping () -> [_TableRow]) {
        self.init(
            caption: caption.map(TableCaption.init(_:)),
            header: header.map { h in
                TableRow {
                    Text(h.0)
                    Text(h.1)
                    Text(h.2)
                }
            }, footer: footer.map { f in
                TableRow {
                    Text(f.0)
                    Text(f.1)
                    Text(f.2)
                }
            }, rows: {
                for row in rows() {
                    row
                }
            }
        )
    }

    init(tableHeader header: (String, String, String, String)? = nil, tableFooter footer: (String, String, String, String)? = nil, caption: String? = nil, @TripleColumnWithHeaderTableRowBuilder rowsWithHeader rows: @escaping () -> [_TableRow]) {
        self.init(header: header, footer: footer, caption: caption, rows: rows)
    }

    // MARK: - Quadruple

    init(header: (String, String, String, String)? = nil, footer: (String, String, String, String)? = nil, caption: String? = nil, @QuadrupleColumnTableRowBuilder rows: @escaping () -> [_TableRow]) {
        self.init(
            caption: caption.map(TableCaption.init(_:)),
            header: header.map { h in
                TableRow {
                    Text(h.0)
                    Text(h.1)
                    Text(h.2)
                    Text(h.3)
                }
            }, footer: footer.map { f in
                TableRow {
                    Text(f.0)
                    Text(f.1)
                    Text(f.2)
                    Text(f.3)
                }
            }, rows: {
                for row in rows() {
                    row
                }
            }
        )
    }

    init(tableHeader header: (String, String, String, String, String)? = nil, tableFooter footer: (String, String, String, String, String)? = nil, caption: String? = nil, @QuadrupleColumnWithHeaderTableRowBuilder rowsWithHeader rows: @escaping () -> [_TableRow]) {
        self.init(header: header, footer: footer, caption: caption, rows: rows)
    }

    // MARK: - Quintuple

    init(header: (String, String, String, String, String)? = nil, footer: (String, String, String, String, String)? = nil, caption: String? = nil, @QuintupleColumnTableRowBuilder rows: @escaping () -> [_TableRow]) {
        self.init(
            caption: caption.map(TableCaption.init(_:)),
            header: header.map { h in
                TableRow {
                    Text(h.0)
                    Text(h.1)
                    Text(h.2)
                    Text(h.3)
                    Text(h.4)
                }
            }, footer: footer.map { f in
                TableRow {
                    Text(f.0)
                    Text(f.1)
                    Text(f.2)
                    Text(f.3)
                    Text(f.4)
                }
            }, rows: {
                for row in rows() {
                    row
                }
            }
        )
    }

    init(tableHeader header: (String, String, String, String, String, String)? = nil, tableFooter footer: (String, String, String, String, String, String)? = nil, caption: String? = nil, @QuintupleColumnWithHeaderTableRowBuilder rowsWithHeader rows: @escaping () -> [_TableRow]) {
        self.init(
            caption: caption.map(TableCaption.init(_:)),
            header: header.map { h in
                TableRow {
                    Text(h.0)
                    Text(h.1)
                    Text(h.2)
                    Text(h.3)
                    Text(h.4)
                    Text(h.5)
                }
            }, footer: footer.map { f in
                TableRow {
                    Text(f.0)
                    Text(f.1)
                    Text(f.2)
                    Text(f.3)
                    Text(f.4)
                    Text(f.5)
                }
            }, rows: {
                for row in rows() {
                    row
                }
            }
        )
    }
}
