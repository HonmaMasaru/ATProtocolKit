//
//  app.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public struct app {
    public struct bsky {
        public struct `actor` {
            public struct defs {}
        }
        public struct embed {}
        public struct feed {
            public struct defs {}
        }
    }
}

// MARK: -

public enum Embed: Codable {
    case image(app.bsky.embed.Images)
    case external(app.bsky.embed.External)
    case record(app.bsky.embed.Record)
    case recordWithMedia(app.bsky.embed.RecordWithMedia)

    public enum `Type`: String, Codable {
        case image = "app.bsky.embed.images"
        case external = "app.bsky.embed.external"
        case record = "app.bsky.embed.record"
        case recordWithMedia = "app.bsky.embed.recordWithMedia"
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
            self = .image(data)
        case .external:
            let data = try app.bsky.embed.External(from: decoder)
            self = .external(data)
        case .record:
            let data = try app.bsky.embed.Record(from: decoder)
            self = .record(data)
        case .recordWithMedia:
            let data = try app.bsky.embed.RecordWithMedia(from: decoder)
            self = .recordWithMedia(data)
        case .none:
            let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
            throw DecodingError.typeMismatch(Embed.self, error)
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .image(let data):
            try data.encode(to: encoder)
        case .external(let data):
            try data.encode(to: encoder)
        case .record(let data):
            try data.encode(to: encoder)
        case .recordWithMedia(let data):
            try data.encode(to: encoder)
        }
    }
}

// MARK: -

public enum ViewEmbed: Codable {
    case image(app.bsky.embed.Images.View)
    case external(app.bsky.embed.External.View)
    case record(app.bsky.embed.Record.View)
    case recordWithMedia(app.bsky.embed.RecordWithMedia.View)

    public enum `Type`: String, Codable {
        case image = "app.bsky.embed.images#view"
        case external = "app.bsky.embed.external#view"
        case record = "app.bsky.embed.record#view"
        case recordWithMedia = "app.bsky.embed.recordWithMedia#view"
    }

    private enum CodingKeys: String, CodingKey {
        case type = "$type"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decodeIfPresent(`Type`.self, forKey: .type)
        switch type {
        case .image:
            let data = try app.bsky.embed.Images.View(from: decoder)
            self = .image(data)
        case .external:
            let data = try app.bsky.embed.External.View(from: decoder)
            self = .external(data)
        case .record:
            let data = try app.bsky.embed.Record.View(from: decoder)
            self = .record(data)
        case .recordWithMedia:
            let data = try app.bsky.embed.RecordWithMedia.View(from: decoder)
            self = .recordWithMedia(data)
        case .none:
            let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
            throw DecodingError.typeMismatch(Embed.self, error)
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .image(let data):
            try data.encode(to: encoder)
        case .external(let data):
            try data.encode(to: encoder)
        case .record(let data):
            try data.encode(to: encoder)
        case .recordWithMedia(let data):
            try data.encode(to: encoder)
        }
    }
}
