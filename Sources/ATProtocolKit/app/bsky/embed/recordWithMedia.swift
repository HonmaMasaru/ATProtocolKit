//
//  recordWithMedia.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension app.bsky.embed {
    /// A representation of a record embedded in another form of content, alongside other compatible embeds
    struct RecordWithMedia: Codable {
        public let record: app.bsky.embed.Record
        public let media: Media

        public struct View: Codable {
            public let record: app.bsky.embed.Record.View
            public let media: ViewMedia
        }
    }
}

// MARK: -

public enum Media: Codable {
    case images(app.bsky.embed.Images)
    case external(app.bsky.embed.External)

    private enum CodingKeys: String, CodingKey {
        case images, external
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(.images) {
            self = .images(try app.bsky.embed.Images(from: decoder))
        }
        if container.contains(.external) {
            self = .external(try app.bsky.embed.External(from: decoder))
        }
        let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
        throw DecodingError.typeMismatch(Media.self, error)
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .images(let data):
            try data.encode(to: encoder)
        case .external(let data):
            try data.encode(to: encoder)
        }
    }
}

// MARK: -

public enum ViewMedia: Codable {
    case images(app.bsky.embed.Images.View)
    case external(app.bsky.embed.External.View)

    private enum CodingKeys: String, CodingKey {
        case images, external
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(.images) {
            self = .images(try app.bsky.embed.Images.View(from: decoder))
        }
        if container.contains(.external) {
            self = .external(try app.bsky.embed.External.View(from: decoder))
        }
        let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
        throw DecodingError.typeMismatch(ViewMedia.self, error)
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .images(let data):
            try data.encode(to: encoder)
        case .external(let data):
            try data.encode(to: encoder)
        }
    }
}
