//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public final class Report {
    // MARK: - Properties

    public var configuration: Configuration
    public var titlePage: TitlePage
    public var sections: ContiguousArray<Section>

    public private(set) var context: Context?
    private let timeZone: TimeZone
    private let calendarID: Calendar.Identifier?
    private let locale: Locale?

    // MARK: - Init

    public init(title: String, titlePage: TitlePage, timeZone: TimeZone, calendarID: Calendar.Identifier? = nil, locale: Locale? = nil, sections: ContiguousArray<Section> = []) {
        self.configuration = Configuration(title: title)
        self.titlePage = titlePage
        self.sections = sections
        self.timeZone = timeZone
        self.calendarID = calendarID
        self.locale = locale
    }

    public convenience init(title: String, titlePage: TitlePage, timeZone: TimeZone, calendarID: Calendar.Identifier? = nil, locale: Locale? = nil, @ReportSectionArrayBuilder sections: () -> ContiguousArray<Section>) {
        self.init(title: title, titlePage: titlePage, timeZone: timeZone, calendarID: calendarID, locale: locale, sections: sections())
    }
}

// MARK: - Functions

public extension Report {
    func generateHTML(context existingContext: Context? = nil) throws -> String {
        let context = existingContext ?? Context(template: .reportTemplate, localTimeZone: timeZone, calendarID: calendarID, locale: locale)
        self.context = context

        let head: HTMLElement
        if let existing = context.template.head() {
            head = existing
        } else {
            head = try context.template.appendElement(.head)
        }
        try head.appendChild(try configuration.htmlNode(context: context))

        let body: HTMLElement
        if let existing = context.template.body() {
            body = existing
        } else {
            body = try context.template.appendElement(.body)
        }

        let titlePageElement = try titlePage.htmlNode(context: context)
        try body.appendChild(titlePageElement)

        for section in sections {
            let sectionElement = try section.htmlNode(context: context)
            try body.appendChild(sectionElement)
        }

        return try context.template.outerHtml()
    }

    @discardableResult
    func saveGeneratedHTML(to destination: URL, context existingContext: Context? = nil) throws -> URL {
        let html = try generateHTML(context: existingContext)
        try Data(html.utf8).write(to: destination, options: .atomic)
        return destination
    }
}
