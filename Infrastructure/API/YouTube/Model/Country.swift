//
//  Copyright © 2020 Tasuku Tozawa. All rights reserved.
//

extension YouTube {
    public enum Country {
        case japan
        case america
        case china

        /**
         * See: https://www.iso.org/iso-3166-country-codes.html
         */
        var alpha2Code: String {
            switch self {
            case .japan:
                return "JP"
            case .america:
                return "UA"
            case .china:
                return "CN"
            }
        }
    }
}
