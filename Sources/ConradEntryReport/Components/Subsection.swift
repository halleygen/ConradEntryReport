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
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let sectionElement = HTMLElement(.division, "")

        let headingElement = try heading.htmlNode(context: context)
        try sectionElement.appendChild(headingElement)

        for component in components {
            let componentWrapper = try sectionElement.appendElement(.division)
            let componentContent = try component.htmlNode(context: context)
            try componentWrapper.appendChild(componentContent)
        }

        return sectionElement
    }
}

let sect = Section(heading: "Heading", components: [
])
