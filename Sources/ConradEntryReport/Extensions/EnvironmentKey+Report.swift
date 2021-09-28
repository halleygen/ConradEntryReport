//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

import Foundation
import Plot

extension EnvironmentKey where Value == Report.RenderContext? {
    static var context: Self { Self() }
}
