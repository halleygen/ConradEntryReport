//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public struct TitlePage {
    public var heading: DocumentHeading
    public var vesselPhoto: Figure
    public var components: ContiguousArray<(String, HTMLTextConvertible)>

    public init(heading: DocumentHeading, vesselPhoto: Figure, components: ContiguousArray<(String, HTMLTextConvertible)>) {
        self.heading = heading
        self.components = components
        self.vesselPhoto = vesselPhoto
    }

    @_disfavoredOverload
    public init(heading: DocumentHeading, vesselPhoto: Figure, components: ContiguousArray<(String, HTMLTextConvertible?)>) {
        let compacted = components.compactMap { title, component -> (String, HTMLTextConvertible)? in
            guard let component = component else { return nil }
            return (title, component)
        }

        self.init(heading: heading, vesselPhoto: vesselPhoto, components: ContiguousArray(compacted))
    }
}

extension TitlePage: HTMLComponent {
    public func htmlNode(context: Report.Context) throws -> HTMLNode {
        let sectionElement = HTMLElement(.section, "")

        let headingElement = try heading.htmlNode(context: context)
        try sectionElement.appendChild(headingElement)

        for (title, value) in components {
            let keyValuePair = Bold { KeyValuePair(key: title, value: value) }
            let content = try keyValuePair.htmlNode(context: context)
            try sectionElement.appendChild(content)
            _ = try sectionElement.appendElement(.lineBreak)
        }

        let vesselPhotoElement = try vesselPhoto.htmlNode(context: context)
        try sectionElement.appendChild(vesselPhotoElement)

        return sectionElement
    }
}

private extension TitlePage {
    struct KeyValuePair: HTMLComponent {
        let key: HTMLTextConvertible
        let value: HTMLTextConvertible

        func htmlNode(context: Report.Context) throws -> HTMLNode {
            let text = Text(key.htmlString(context: context) + ": " + value.htmlString(context: context))
            return try text.htmlNode(context: context)
        }
    }
}
