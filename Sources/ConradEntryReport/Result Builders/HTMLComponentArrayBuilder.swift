//
//  File.swift
//  
//
//  Created by Jesse Halley on 14/6/21.
//

@resultBuilder
enum HTMLComponentArrayBuilder {
    static func buildBlock(_ components: [HTMLComponent]...) -> [HTMLComponent] {
        components.flatMap { $0 }
    }
    
    static func buildExpression(_ expression: HTMLComponent) -> [HTMLComponent] {
        [expression]
    }
    
    static func buildExpression(_ expression: HTMLComponent?) -> [HTMLComponent] {
        if let expression = expression {
            return [expression]
        } else {
            return []
        }
    }
    
    static func buildOptional(_ component: [HTMLComponent]?) -> [HTMLComponent] {
        component ?? []
    }
    
    static func buildEither(first component: [HTMLComponent]) -> [HTMLComponent] {
        component
    }
    
    static func buildEither(second component: [HTMLComponent]) -> [HTMLComponent] {
        component
    }
    
    static func buildFinalResult(_ component: [HTMLComponent]) -> ContiguousArray<HTMLComponent> {
        ContiguousArray(component)
    }
}
