//
//  createRecord.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension com.atproto.repo {

    struct createRecord: ATProtocolAPI {
        /// Request
        public typealias APIRequest = Request
        /// Response
        public typealias APIResponse = Response

        /// ID
        public let id: String = "com.atproto.repo.createRecord"
        /// Type
        public let type: StructureType = .procedure
        /// Encoding
        public let encoding: String? = "application/json"
        /// Request
        public var request: Request

        /// Initialize
        /// - Parameters:
        ///   - repo: handle or DID of the repo
        ///   - rkey: key of the record
        ///   - validate: Validate the record
        ///   - record: record to create.
        ///   - swapCommit: cid
        public init(repo: String, rkey: String? = nil, validate: Bool? = nil, record: Record, swapCommit: String? = nil) {
            request = .init(repo: repo, rkey: rkey, validate: validate, record: record, swapCommit: swapCommit)
        }

        /// Initialize
        /// - Parameters:
        ///   - repo: handle or DID of the repo
        ///   - text: Text
        ///   - createdAt: Date
        ///   - embed: Embed
        public init(repo: String, text: String, createdAt: Date, embed: Embed? = nil) {
            let record = Record(text: text, createdAt: createdAt, embed: embed)
            self.init(repo: repo, record: record)
        }

        /// Create a new record.
        public struct Request: ATProtocolRequest {
            /// The handle or DID of the repo.
            /// - Note: format = at-identifier
            public let repo: String

            /// The NSID of the record collection.
            /// - Note: format = nsid
            public let collection: String

            /// The key of the record.
            public let rkey: String?

            /// Validate the record?
            /// - Note: default = true
            public let validate: Bool?

            /// The record to create.
            public let record: Record

            /// Compare and swap with the previous commit by cid.
            /// - Note: format = cid
            public let swapCommit: String?

            /// Initialize
            /// - Parameters:
            ///   - repo: handle or DID of the repo
            ///   - rkey: key of the record
            ///   - validate: Validate the record
            ///   - record: record to create.
            ///   - swapCommit: cid
            init(repo: String, rkey: String? = nil, validate: Bool? = nil, record: Record, swapCommit: String? = nil) {
                self.repo = repo
                self.collection = "app.bsky.feed.post"
                self.rkey = rkey
                self.validate = validate
                self.record = record
                self.swapCommit = swapCommit
            }
        }

        /// Create a new record.
        public struct Response: ATProtocolResponse {
            /// - Note: format = at-uri
            public let uri: String

            /// - Note: format = cid
            public let cid: String
        }
    }

    // MARK: -

    struct Record: Codable {
        public let type: String = "app.bsky.feed.post"
        public let text: String
        public let createdAt: String
        public let embed: Embed?

        init(text: String, createdAt: Date, embed: Embed? = nil) {
            self.text = text
            self.createdAt = ISO8601DateFormatter().string(from: createdAt)
            self.embed = embed
        }

        private enum CodingKeys: String, CodingKey {
            case text, createdAt, embed
            case type = "$type"
        }
    }

    struct Embed: Codable {
        public let type: String = "app.bsky.embed.images"
        public let external: External?
        public let images: [com.atproto.repo.Image]?

        init(external: External? = nil, images: [com.atproto.repo.Image]? = nil) {
            self.external = external
            self.images = images
        }

        private enum CodingKeys: String, CodingKey {
            case external, images
            case type = "$type"
        }
    }

    struct External: Codable {
        public let uri: String
        public let title: String
        public let description: String
//        public let thumb: Data // "maxWidth": 1000, "maxHeight": 1000, "maxSize": 300000
    }

    struct Image: Codable {
        public let cid: String // "maxWidth": 1000, "maxHeight": 1000, "maxSize": 300000
        public let mimeType: String
    }
}
