//
//  external.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension app.bsky.embed {
    /// A representation of some externally linked content, embedded in another form of content
    struct External: Codable {
        public let external: External

        public struct External: Codable {
            /// format: uri
            public let uri: String
            public let title: String
            public let description: String
            /// maxSize: 1000000
            public let thumb: Thumb?
        }

        public struct View: Codable {
            public let external: ViewExternal
        }

        public struct ViewExternal: Codable {
            /// format: uri
            public let uri: String
            public let title: String
            public let description: String
            public let thumb: String?
        }

        public struct Thumb: Codable {
            public let type: String
            public let ref: ThumbRef
            public let mimeType: String
            public let size: Int

            private enum CodingKeys: String, CodingKey {
                case ref, mimeType, size
                case type = "$type"
            }
        }

        public struct ThumbRef: Codable {
            public let link: String

            private enum CodingKeys: String, CodingKey {
                case link = "$link"
            }
        }
    }
}
