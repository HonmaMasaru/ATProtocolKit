//
//  getTimeline.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension app.bsky.feed {
    /// <#Description#>
    struct getTimeline: ATProtocolAPI {
        /// Request
        public typealias APIRequest = Request
        /// Response
        public typealias APIResponse = Response

        /// ID
        public let id: String = "app.bsky.feed.getTimeline"
        /// Type
        public let type: StructureType = .query
        /// Encoding
        public let encoding: String? = nil
        /// Request
        public var request: Request

        /// 初期化
        public init(algorithm: String? = nil, limit: Int? = nil, cursor: String? = nil) {
            request = .init(algorithm: algorithm, limit: limit, cursor: cursor)
        }

        /// A view of the user's home timeline.
        public struct Request: ATProtocolRequest {
            /// algorithm
            public let algorithm: String?

            /// limit
            /// - Note: minimum = 1, maximum = 100, default = 50
            public let limit: Int?

            /// cursor
            public let cursor: String?

            /// 初期化
            /// - Parameters:
            ///   - algorithm: algorithm
            ///   - limit: limit
            ///   - cursor: cursor
            init(algorithm: String? = nil, limit: Int? = nil, cursor: String? = nil) {
                self.algorithm = algorithm
                self.limit = limit
                self.cursor = cursor
            }
        }

        /// Create a new record.
        public struct Response: ATProtocolResponse {
            /// feed
            public let feed: [app.bsky.feed.defs.FeedViewPost]

            /// cursor
            public let cursor: String?
        }
    }
}
