//
//  images.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension app.bsky.embed {
    /// A set of images embedded in some other form of content,
    struct Images: Codable {
        /// maxLength: 4
        public let images: [Image]

        public struct Image: Codable {
            public let type: String?
            public let ref: ImageRef?
            public let mimeType: String?
            public let size: Int?
            public let alt: String?
        }

        public struct ImageRef: Codable {
            public let link: String

            private enum CodingKeys: String, CodingKey {
                case link = "$link"
            }
        }

        public struct View: Codable {
            /// maxLength: 4
            public let images: [ViewImage]
        }

        public struct ViewImage: Codable {
            public let thumb: String?
            public let fullsize: String?
            public let alt: String?
        }
    }
}
