//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import APIKit

/**
 * SwiftのDecodableでData型を扱うため、あえて何もパースを行わないようにするDataParser
 */
class NOPDataParser: APIKit.DataParser {
    var contentType: String? {
        "application/json"
    }

    func parse(data: Data) throws -> Any {
        data
    }
}
