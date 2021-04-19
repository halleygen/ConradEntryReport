//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public struct Section {
    public var heading: SectionHeading
    public var components: ContiguousArray<HTMLComponent>

    public init(heading: SectionHeading, components: ContiguousArray<HTMLComponent>) {
        self.heading = heading
        self.components = components
    }
}

public extension Section {
    init(title: String, components: ContiguousArray<HTMLComponent>) {
        self.init(heading: SectionHeading(content: title), components: components)
    }
}

extension Section: HTMLComponent {
    public func htmlElement(context: Report.Context) throws -> HTMLElement {
        let sectionElement = HTMLElement(.section, "")

        let headingElement = try heading.htmlElement(context: context)
        try sectionElement.appendChild(headingElement)

        for component in components {
            let componentWrapper = try sectionElement.appendElement(.division)
            let componentContent = try component.htmlElement(context: context)
            try componentWrapper.appendChild(componentContent)
        }

        return sectionElement
    }
}
