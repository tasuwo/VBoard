//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

import APIKit

/**
 * SwiftのDecodableでData型を扱うため、あえて何もパースを行わないようにするDataParser
 */
class NOPDataParser: APIKit.DataParser {
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}
