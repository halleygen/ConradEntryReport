//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public struct Section {
    public var heading: SectionHeading
    public var components: ContiguousArray<HTMLComponent>

    public init(heading: SectionHeading, @HTMLComponentArrayBuilder components: () -> ContiguousArray<HTMLComponent>) {
        self.init(heading: heading, components: components())
    }

    public init(heading: SectionHeading, components: ContiguousArray<HTMLComponent>) {
        self.heading = heading
        self.components = components
    }

    @_disfavoredOverload
    public init(heading: SectionHeading, components: ContiguousArray<HTMLComponent?>) {
        self.init(heading: heading, components: ContiguousArray(components.compacting()))
    }
}

extension Section: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let sectionElement = HTMLElement(.section, "")

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
