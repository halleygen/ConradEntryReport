//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation
import Plot

public struct Report {
    public let title: String
    public let titlePage: TitlePage

    public let locale: Locale
    public let calendarID: Calendar.Identifier
    public let timeZone: TimeZone
    @ComponentBuilder public let components: () -> Component

    public init(title: String, titlePage: TitlePage, timeZone: TimeZone, calendarID: Calendar.Identifier? = nil, locale: Locale? = nil, @ComponentBuilder components: @escaping () -> Component) {
        self.title = title
        self.titlePage = titlePage
        self.timeZone = timeZone
        self.calendarID = calendarID ?? .iso8601
        self.locale = locale ?? .posix
        self.components = components
    }

    private func html(printOptions: PrintOptions) -> HTML {
        HTML(
            .lang(.english),
            .head(
                .title(title),
                .meta(.attribute(named: "title", value: title)),
                .meta(.attribute(named: "author", value: "Conrad Partners")),
                .meta(.attribute(named: "subject", value: "WSMD Report")),
                .meta(.attribute(named: "date", value: ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withDay, .withMonth, .withYear, .withDashSeparatorInDate]))),
                .meta(.charset(.utf8)),
                .style(printOptions.serialised())
            ),
            .body(
                .component(titlePage),
                .component(components()),
                .component(printOptions.header.logo)
            )
        )
        .environmentValue(Context(localTimeZone: timeZone, calendarID: calendarID, locale: locale), key: .context)
    }

    public func render(printOptions: PrintOptions, minified: Bool = true) -> String { html(printOptions: printOptions).render(indentedBy: minified ? nil : .tabs(1)) }
}
