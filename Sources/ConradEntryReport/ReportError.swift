//
// ConradEntryReport
// Copyright © 2021 Jesse Halley. All rights reserved.
//

public enum ReportError: Error {
    case utf8EncodeFailure(String)
    case emptyTable(Table)
}
