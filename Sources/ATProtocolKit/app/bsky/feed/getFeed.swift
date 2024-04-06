//
//  getFeed.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2024/02/24.
//

import Foundation

public extension app.bsky.feed {
    /// getFeed
    struct getFeed: ATProtocolAPI {
        /// Request
        public typealias APIRequest = Request
        /// Response
        public typealias APIResponse = Response

        /// ID
        public let id: String = "app.bsky.feed.getFeed"
        /// Type
        public let type: StructureType = .query
        /// Encoding
        public let encoding: String? = nil
        /// Request
        public var request: Request

        /// 初期化
        /// - Parameters:
        ///   - feed: feed
        ///   - limit: limit
        ///   - cursor: cursor
        public init(feed: String, limit: Int? = nil, cursor: String? = nil) {
            request = .init(feed: feed, limit: limit, cursor: cursor)
        }

        /// A view of the user's home timeline.
        public struct Request: ATProtocolRequest {
            /// feed
            public let feed: String
            /// limit
            /// - Note: minimum = 1, maximum = 100, default = 50
            public let limit: Int?
            /// cursor
            public let cursor: String?

            /// 初期化
            /// - Parameters:
            ///   - feed: feed
            ///   - limit: limit
            ///   - cursor: cursor
            init(feed: String, limit: Int? = nil, cursor: String? = nil) {
                self.feed = feed
                self.cursor = cursor
                self.limit = if let limit, (1...100).contains(limit) {
                    limit
                } else {
                    nil
                }
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
