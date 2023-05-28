//
//  strongRef.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension com.atproto.repo {
    /// A URI with a content-hash fingerprint.
    struct StrongRef: Codable {
        /// format: at-uri
        public let uri: String

        /// format: cid
        public let cid: String
    }
}
