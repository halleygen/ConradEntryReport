//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

@testable import ConradEntryReport
import Plot
import XCTest

extension Locale {
    static let `default` = Locale(identifier: "en_GB@calendar=iso8601;currency=USD")
}

final class ConradEntryReportTests: XCTestCase {
    func test_html() throws {
        let titlePage = TitlePage(title: "Test Title", vesselPhoto: Figure(image: Image("vesselphoto.jpeg"), timeStamp: Date(), comment: "Vessel at berth"), components: ["One": "1", "Two": "2", "Three": "3"])
        let rep = Report(title: "Test Title", titlePage: titlePage, timeZone: TimeZone(secondsFromGMT: 0)!, locale: .default) {
            Section(title: "Section 1") {
                OrderedList(1 ... 10, content: { Text(String($0)) })
            }

            Section(title: "Another Section") {
                Subsection(title: "Subsection A") {
                    Text("qwertyuiop")
                }

                Subsection(title: "Subsection B") {
                    Text("qwertyuiop")
                }

                Subsection(title: "Subsection C") {
                    Text("qwertyuiop")
                }
            }
        }

        let html = rep.render(printOptions: PrintOptions(), minified: false)
        print(html)
        XCTAssertTrue(true)
    }

    func test_tables() throws {
        let _ = HTML {
            Table {
                (1, 2)
                (1, 2)
                (1, 2)
            }
        }

        let str1 = HTML {
            Table(header: "header", footer: "footer", caption: "Single Caption") {
                "Element"
                "Element"
                "Element"
            }
        }
        .environmentValue(Report.RenderContext(localTimeZone: .current, locale: .default), key: .context)
        .render(indentedBy: .tabs(1))
        print(str1)

        let str2 = HTML {
            Table(header: ("header", "header"), footer: ("footer", "footer"), caption: "Double Caption") {
                ("Element", "Element")
                ("Element", "Element")
                ("Element", "Element")
            }
        }
        .environmentValue(Report.RenderContext(localTimeZone: .current, locale: .default), key: .context)
        .render(indentedBy: .tabs(1))
        print(str2)

        let str3 = HTML {
            Table(header: ("header", "header", "header"), footer: ("footer", "footer", "footer"), caption: "Triple Caption") {
                ("Element", "Element", "Element")
                ("Element", "Element", "Element")
                ("Element", "Element", "Element")
                (1, 2, 3)
            }
        }
        .environmentValue(Report.RenderContext(localTimeZone: .current, locale: .default), key: .context)
        .render(indentedBy: .tabs(1))
        print(str3)

        let str1WithHeader = HTML {
            Table(tableHeader: ("header", "header", "header", "header"), tableFooter: ("footer", "footer", "footer", "footer"), caption: "Triple Caption") {
                ("Header Cell", ("Element", "Element", "Element"))
                ("Header Cell", ("Element", "Element", "Element"))
                ("Header Cell", ("Element", "Element", "Element"))
                ("Header Cell", (1, 2, 3))
            }
        }
        .environmentValue(Report.RenderContext(localTimeZone: .current, locale: .default), key: .context)
        .render(indentedBy: .tabs(1))
        print(str1WithHeader)

        let altHeader = HTML {
            Table(
                caption: TableCaption("Triple Caption"),
                header: TableRow {
                    Text("header")
                    Text("header")
                    Text("header")
                },
                footer: TableRow {
                    Text("footer")
                    Text("footer")
                    Text("footer")
                },
                rows: {
                    for _ in 1 ... 3 {
                        TableRow {
                            TableHeaderCell("Header Cell")
                            TableCell("Element")
                            TableCell("Element")
                            TableCell("Element")
                        }
                    }

                    TableRow {
                        TableHeaderCell("Header Cell")
                        TableCell("1")
                        TableCell("2")
                        TableCell("3")
                    }
                }
            )
        }
        .render(indentedBy: .tabs(1))
        print(altHeader)
    }
}
