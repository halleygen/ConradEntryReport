//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Plot

public extension TableCell {
    init<T: HTMLTextConvertible>(_ value: T) {
        self.init(Value(value))
    }
}

public extension Table {
    init(header: String? = nil, footer: String? = nil, caption: String? = nil, @SingleColumnTableRowBuilder rows: @escaping () -> [TableRow]) {
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

    init(header: (String, String)? = nil, footer: (String, String)? = nil, caption: String? = nil, @DoubleColumnTableRowBuilder rows: @escaping () -> [TableRow]) {
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

    init(header: (String, String, String)? = nil, footer: (String, String, String)? = nil, caption: String? = nil, @TripleColumnTableRowBuilder rows: @escaping () -> [TableRow]) {
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

    init(header: (String, String, String, String)? = nil, footer: (String, String, String, String)? = nil, caption: String? = nil, @QuadrupleColumnTableRowBuilder rows: @escaping () -> [TableRow]) {
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

    init(header: (String, String, String, String, String)? = nil, footer: (String, String, String, String, String)? = nil, caption: String? = nil, @QuintupleColumnTableRowBuilder rows: @escaping () -> [TableRow]) {
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
}
