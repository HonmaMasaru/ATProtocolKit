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

    public enum `Type`: String, Codable {
        case image = "app.bsky.embed.images"
        case external = "app.bsky.embed.external"
    }

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decodeIfPresent(`Type`.self, forKey: .type)
        switch type {
        case .image:
            let data = try app.bsky.embed.Images(from: decoder)
            self = .images(data)
        case .external:
            let data = try app.bsky.embed.External(from: decoder)
            self = .external(data)
        case .none:
            let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
            throw DecodingError.typeMismatch(app.bsky.embed.Embed.self, error)
        }
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

    public enum `Type`: String, Codable {
        case image = "app.bsky.embed.images#view"
        case external = "app.bsky.embed.external#view"
    }

    private enum CodingKeys: String, CodingKey {
        case images, external
        case type = "$type"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decodeIfPresent(`Type`.self, forKey: .type)
        switch type {
        case .image:
            let data = try app.bsky.embed.Images.View(from: decoder)
            self = .images(data)
        case .external:
            let data = try app.bsky.embed.External.View(from: decoder)
            self = .external(data)
        case .none:
            let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
            throw DecodingError.typeMismatch(app.bsky.embed.Embed.self, error)
        }
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
