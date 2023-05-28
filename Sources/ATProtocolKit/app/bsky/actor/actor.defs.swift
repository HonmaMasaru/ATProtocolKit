//
//  defs.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension app.bsky.actor.defs {
    struct ProfileViewBasic: Codable {
        /// format: did
        public let did: String

        /// format: handle
        public let handle: String

        /// maxGraphemes: 64, maxLength: 640
        public let displayName: String?

        public let avatar: String?

        public let viewer: ViewerState?

        public let labels: [com.atproto.label.defs.Label]?
    }

    struct ProfileView: Codable {
        /// format: did
        public let did: String

        /// format: handle
        public let handle: String

        /// maxGraphemes: 64, maxLength: 640
        public let displayName: String?

        /// maxGraphemes: 256, maxLength: 2560
        public let description: String?

        public let avatar: String?

        /// format: datetime
        public let indexedAt: String?

        public let viewer: ViewerState

        public let labels: [com.atproto.label.defs.Label]?
    }

    struct ProfileViewDetailed: Codable {
        /// format: did
        public let did: String

        /// format: handle
        public let handle: String

        /// maxGraphemes: 64, maxLength: 640
        public let displayName: String?

        /// maxGraphemes: 256, maxLength: 2560
        public let description: String?

        public let avatar: String?

        public let banner: String?

        public let followersCount: Int?

        public let followsCount: Int?

        public let postsCount: Int?

        /// format: datetime
        public let indexedAt: String?

        public let viewer: ViewerState?

        public let labels: [com.atproto.label.defs.Label]?
    }

    struct ViewerState: Codable {
        public let muted: Bool

        public let blockedBy: Bool

        /// format: at-uri
        public let blocking: String?

        /// format: at-uri
        public let following: String?

        /// format: at-uri
        public let followedBy: String?
    }
}
