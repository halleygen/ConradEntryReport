//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

public protocol HTMLComponent {
    func htmlNode(context: Report.Context) throws -> HTMLNode
}
