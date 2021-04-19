//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation

extension URL {
    static var reportTemplate: URL { Bundle.module.url(forResource: "ReportTemplate", withExtension: "html")! }
}
