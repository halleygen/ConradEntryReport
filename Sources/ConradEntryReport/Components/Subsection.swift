//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public struct Subsection {
    public var heading: SubsectionHeading
    public var components: ContiguousArray<HTMLComponent>

    public init(heading: SubsectionHeading, components: ContiguousArray<HTMLComponent>) {
        self.heading = heading
        self.components = components
    }

    @_disfavoredOverload
    public init(heading: SubsectionHeading, components: ContiguousArray<HTMLComponent?>) {
        self.init(heading: heading, components: ContiguousArray(components.compactMap { $0 }))
    }
}

extension Subsection: HTMLComponent {
    public func htmlElement(context: Report.Context) throws -> HTMLElement {
        let sectionElement = HTMLElement(.division, "")

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

let sect = Section(heading: "Heading", components: [
])
