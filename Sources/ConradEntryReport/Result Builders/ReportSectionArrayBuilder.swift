//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

@resultBuilder
public enum ReportSectionArrayBuilder {
    public static func buildBlock(_ components: [Section]...) -> [Section] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: Section) -> [Section] {
        [expression]
    }

    public static func buildExpression(_ expression: Section?) -> [Section] {
        if let expression = expression {
            return [expression]
        } else {
            return []
        }
    }

    public static func buildOptional(_ component: [Section]?) -> [Section] {
        component ?? []
    }

    public static func buildEither(first component: [Section]) -> [Section] {
        component
    }

    public static func buildEither(second component: [Section]) -> [Section] {
        component
    }

    public static func buildFinalResult(_ component: [Section]) -> ContiguousArray<Section> {
        ContiguousArray(component)
    }
}
