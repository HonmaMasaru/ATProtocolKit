//
//  defs.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension app.bsky.feed.defs {
    struct PostView: Codable {
        /// format: at-uri
        public let uri: String

        /// format: cid
        public let cid: String

        public let author: app.bsky.actor.defs.ProfileViewBasic

        /// type: unknown
        public let record: app.bsky.feed.Post?

        public let embed: ViewEmbed?

        public let replyCount: Int?

        public let repostCount: Int?

        public let likeCount: Int?

        /// format: datetime
        public let indexedAt: String

        public let viewer: ViewerState?

        public let labels: [com.atproto.label.defs.Label]?
    }

    struct ViewerState: Codable {
        /// format: at-uri
        public let repost: String?

        /// format: at-uri
        public let like: String?
    }

    struct FeedViewPost: Codable {
        public let post: PostView
        public let reply: ReplyRef?
        public let reason: ReasonRepost?
    }

    struct ReplyRef: Codable {
        public let root: PostView
        public let parent: PostView
    }

    struct ReasonRepost: Codable {
        public let by: app.bsky.actor.defs.ProfileViewBasic
        
        /// format: datetime
        public let indexedAt: String
    }

    struct ThreadViewPost: Codable {
        public let post: PostView
        public let parent: [PostType]?
        public let replies: [PostType]
    }

    struct NotFoundPost: Codable {
        /// format: at-uri
        public let uri: String

        /// const: true
        public let notFound: Bool
    }

    struct BlockedPost: Codable {
        /// format: at-uri
        public let uri: String

        /// const: true
        public let blocked: Bool
    }
}

// MARK: -

public enum PostType: Codable {
    case threadViewPost(app.bsky.feed.defs.ThreadViewPost)
    case notFoundPost(app.bsky.feed.defs.NotFoundPost)
    case blockedPost(app.bsky.feed.defs.BlockedPost)

    private enum CodingKeys: String, CodingKey {
        case threadViewPost, notFoundPost, blockedPost
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(.threadViewPost) {
            self = .threadViewPost(try app.bsky.feed.defs.ThreadViewPost(from: decoder))
        }
        if container.contains(.notFoundPost) {
            self = .notFoundPost(try app.bsky.feed.defs.NotFoundPost(from: decoder))
        }
        if container.contains(.blockedPost) {
            self = .blockedPost(try app.bsky.feed.defs.BlockedPost(from: decoder))
        }
        let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
        throw DecodingError.typeMismatch(PostType.self, error)
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .threadViewPost(let data):
            try data.encode(to: encoder)
        case .notFoundPost(let data):
            try data.encode(to: encoder)
        case .blockedPost(let data):
            try data.encode(to: encoder)
        }
    }
}

