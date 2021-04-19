//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

@resultBuilder
private enum SectionBuilder {
    static func buildBlock() -> ContiguousArray<HTMLComponent> { [] }
    static func buildBlock(_ components: HTMLComponent...) -> ContiguousArray<HTMLComponent> { ContiguousArray(components) }
}

private extension Section {
    init(heading: SectionHeading, @SectionBuilder builder: () -> ContiguousArray<HTMLComponent>) {
        self.init(heading: heading, components: builder())
    }
}
