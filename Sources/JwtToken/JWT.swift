//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 17.07.2023.
//

import Foundation

public struct JWT: Codable {
    public var token: String?

    /// Returns the decoded body section of the JWT token as a dictionary.
    public var body: [String: Any]? {
        guard let token = token,
              let data = extractData(from: token, of: .body) else { return nil }

        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }

    /// Returns the decoded header section of the JWT token as a dictionary.
    public var header: [String: Any]? {
        guard let token = token,
              let data = extractData(from: token, of: .header) else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }

    /// Returns the signature section of the JWT token.
    public var signature: String? {
        guard let token = token else { return nil }
        let tokenComponents = token.components(separatedBy: ".")
        guard tokenComponents.count == 3 else { return nil }
        return tokenComponents[2]
    }

    public init(token: String? = nil) {
        self.token = token
    }

    public init(from decoder: Decoder) throws {
        let keyedValue = try decoder.container(keyedBy: CodingKeys.self)
        let singleValue = try decoder.singleValueContainer()

        if let value = try? singleValue.decode(String.self) {
            token = value
        }

        if let value = try? keyedValue.decodeIfPresent(String.self, forKey: .token) {
            token = value
        }
    }

    /// Returns the expiration date/time extracted from the body section of the JWT token.
    public var expiresAt: Date? {
        guard let timestamp: TimeInterval = body?["exp"] as? Double else { return nil }
        return Date(timeIntervalSince1970: timestamp)
    }

    /// Returns the issuer (iss) claim from the body section of the JWT token.
    public var issuer: String? {
        return body?["iss"] as? String
    }

    /// Returns the subject (sub) claim from the body section of the JWT token.
    public var subject: String? {
        return body?["sub"] as? String
    }

    /// Returns the audience (aud) claim from the body section of the JWT token as an array of strings.
    public var audience: [String]? {
        guard let arr = body?["aud"] as? [String] else {
            if let str = body?["aud"] as? String {
                return [str]
            }
            return nil
        }
        return arr
    }

    /// Returns the issued-at date/time extracted from the body section of the JWT token.
    public var issuedAt: Date? {
        guard let timestamp: TimeInterval = body?["iat"] as? Double else { return nil }
        return Date(timeIntervalSince1970: timestamp)
    }

    /// Returns the not-before date/time extracted from the body section of the JWT token.
    public var notBefore: Date? {
        guard let timestamp: TimeInterval = body?["nbf"] as? Double else { return nil }
        return Date(timeIntervalSince1970: timestamp)
    }

    /// Returns the identifier (jti) claim from the body section of the JWT token.
    public var identifier: String? {
        return body?["jti"] as? String
    }

    /// Checks if the JWT token has expired.
    public var expired: Bool {
        guard let date = expiresAt else {
            return false
        }
        return date.compare(Date()) != ComparisonResult.orderedDescending
    }
}
