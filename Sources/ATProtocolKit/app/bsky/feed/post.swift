//
//  Post.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/28.
//

import Foundation

public extension app.bsky.feed {
    struct Post: Codable {
        /// maxLength: 3000, maxGraphemes: 300
        public let text: String

//            public let facets: [app.bsky.richtext.facet]

        public let reply: ReplyRef?

        public let embed: Embed?

        /// format: datetime
        public let createdAt: String

        public struct ReplyRef: Codable {
            public let root: com.atproto.repo.StrongRef
            public let parent: com.atproto.repo.StrongRef
        }
    }
}
