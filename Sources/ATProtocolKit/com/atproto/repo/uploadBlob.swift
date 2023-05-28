//
//  uploadBlob.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension com.atproto.repo {

    struct uploadBlob: ATProtocolAPI {
        /// Request
        public typealias APIRequest = Request
        /// Response
        public typealias APIResponse = Response

        /// ID
        public let id: String = "com.atproto.repo.uploadBlob"
        /// Type
        public let type: StructureType = .procedure
        /// Encoding
        public let encoding: String? = "*/*"
        /// Request
        public var request: Request

        public init(data: Data) {
            request = .init(data: data)
        }

        /// Upload a new blob to be added to repo in a later request.
        public struct Request: ATProtocolRequest {
            /// Data
            public let data: Data
        }

        public struct Response: ATProtocolResponse {
            public let blob: Blob
        }
    }

    struct Blob: Codable {
        public let mimetype: String
        public let size: Int
        public let type: String
        public let ref: Ref

        private enum CodingKeys: String, CodingKey {
            case mimetype, size, ref
            case type = "$type"
        }
    }

    struct Ref: Codable {
        public let link: String

        private enum CodingKeys: String, CodingKey {
            case link = "$link"
        }
    }
}
