//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public struct StyleClass {
    public var selector: String
    public var rules: [String: String]

    public init(selector: String, rules: [String: String]) {
        self.selector = selector
        self.rules = rules
    }

    init(printOptions options: Report.PrintOptions) {
        self.init(selector: "@page", rules: [
            "size": "\(options.pageSize) \(options.pageOrientation)",
            "margin": "\(options.pageMargins)"
        ])
    }

    func serialised() -> String {
        var string = "\(selector) {\n"
        for (rule, value) in rules {
            string.append("\t\(rule): \(value);\n")
        }
        string.append("}")
        return string
    }
}

extension Collection where Element == StyleClass {
    func serialised() -> String {
        reduce(into: "") { partialResult, styleClass in
            partialResult += "\(styleClass.serialised())\n"
        }
    }
}
