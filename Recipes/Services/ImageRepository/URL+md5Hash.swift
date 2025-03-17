//
//  URL+md5Hash.swift
//  Recipes
//
//  Created by David Wright on 3/17/25.
//

import Foundation
import CryptoKit

extension URL {

    /// Returns the URL string hash, using the MD5 hashing function.
    var md5Hash: String {
        Insecure.MD5.hash(data: Data(self.absoluteString.utf8))
            .map { String(format: "%02hhx", $0) } // Convert to a hex string
            .joined()
    }
}
