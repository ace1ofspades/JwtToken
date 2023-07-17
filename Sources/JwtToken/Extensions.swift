//
//  File 3.swift
//  
//
//  Created by Yusuf Tekin on 17.07.2023.
//

import Foundation

extension Double {
    /// Rounds up the double value to the nearest multiple of the given factor.
    func roundedUpToMultiple(of factor: Double) -> Double {
        return ceil(self / factor) * factor
    }
}


extension JWT {
    /// Retrieves the body section of the JWT token and decodes it into the specified type `T`.
    public func getBody<T: Codable>(as type: T.Type) -> T? {
        guard let body = body else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: body) else { return nil }
        let result = try? JSONDecoder().decode(T.self, from: data)
        return result
    }
}

extension JWT {
    func extractData(from token: String, of type: DataType) -> Data? {
        let tokenComponents = token.components(separatedBy: ".")
        guard tokenComponents.count == 3 else { return nil }

        let bodyString = tokenComponents[type.rawValue]
            .replacingOccurrences(of: Constants.dash, with: Constants.plus)
            .replacingOccurrences(of: Constants.underscore, with: Constants.slash)

        let paddedString = padToMultipleOfFour(bodyString)
        return Data(base64Encoded: paddedString, options: .ignoreUnknownCharacters)
    }

    func padToMultipleOfFour(_ input: String) -> String {
        let size = Double(input.lengthOfBytes(using: .utf8))
        let requiredSize = size.roundedUpToMultiple(of: 4)
        let paddingLength = Int(requiredSize - size)
        let paddingString = String(repeating: Constants.equal, count: paddingLength)

        return input + paddingString
    }

    enum Constants {
        static let dash = "-"
        static let underscore = "_"
        static let plus = "+"
        static let slash = "/"
        static let equal = "="
    }

    enum DataType: Int {
        case header = 0
        case body = 1
    }
}
