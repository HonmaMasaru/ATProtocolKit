//
//  defs.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension com.atproto.label.defs {
    /// Metadata tag on an atproto resource (eg, repo or record)
    struct Label: Codable {
        /// DID of the actor who created this label
        /// format: did
        public let src: String

        /// AT URI of the record, repository (account), or other resource which this label applies to
        /// format: uri
        public let uri: String

        /// optionally, CID specifying the specific version of 'uri' resource this label applies to
        /// format: cid
        public let cid: String?

        /// the short string name of the value or type of this label
        /// maxLength: 128
        public let val: String

        /// if true, this is a negation label, overwriting a previous label
        public let neg: Bool?

        /// timestamp when this label was created
        /// format: datetime
        public let cts: String
    }
}
