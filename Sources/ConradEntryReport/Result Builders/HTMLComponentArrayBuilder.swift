//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

@resultBuilder
public enum HTMLComponentArrayBuilder {
    public static func buildBlock(_ components: [HTMLComponent]...) -> [HTMLComponent] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: HTMLComponent) -> [HTMLComponent] {
        [expression]
    }

    public static func buildExpression(_ expression: HTMLComponent?) -> [HTMLComponent] {
        if let expression = expression {
            return [expression]
        } else {
            return []
        }
    }

    public static func buildOptional(_ component: [HTMLComponent]?) -> [HTMLComponent] {
        component ?? []
    }

    public static func buildEither(first component: [HTMLComponent]) -> [HTMLComponent] {
        component
    }

    public static func buildEither(second component: [HTMLComponent]) -> [HTMLComponent] {
        component
    }

    public static func buildFinalResult(_ component: [HTMLComponent]) -> ContiguousArray<HTMLComponent> {
        ContiguousArray(component)
    }
}
