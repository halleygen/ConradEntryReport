//
// ConradEntryReport
// Copyright © 2022 Jesse Halley. All rights reserved.
//

import Foundation
import Plot

public struct Report {
    public let title: String
    public let titlePage: TitlePage

    public let locale: Locale
    public let timeZone: TimeZone
    @ComponentBuilder public let components: () -> Component

    public init(title: String, titlePage: TitlePage, timeZone: TimeZone, locale: Locale, @ComponentBuilder components: @escaping () -> Component) {
        self.title = title
        self.titlePage = titlePage
        self.timeZone = timeZone
        self.locale = locale
        self.components = components
    }

    private func html(printOptions: PrintOptions) -> HTML {
        HTML(
            .lang(.english),
            .head(
                .title(title),
                .meta(.attribute(named: "title", value: title)),
                .meta(.attribute(named: "author", value: "Conrad Partners")),
                .meta(.attribute(named: "description", value: "WSMD Report")),
                .meta(.attribute(named: "dcterms.created", value: ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: .withInternetDateTime))),
                .meta(.charset(.utf8)),
                .style(printOptions.serialised())
            ),
            .body(
                .component(titlePage),
                .component(components()),
                .component(printOptions.header.logo)
            )
        )
        .environmentValue(Report.RenderContext(localTimeZone: timeZone, locale: locale), key: .context)
    }

    public func render(printOptions: PrintOptions, minified: Bool = true) -> String { html(printOptions: printOptions).render(indentedBy: minified ? nil : .tabs(1)) }
}
