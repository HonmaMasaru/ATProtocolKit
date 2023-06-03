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

public extension app.bsky.embed {
    enum Embed: Codable {
        case images(app.bsky.embed.Images)
        case external(app.bsky.embed.External)
        case record(app.bsky.embed.Record)
        case recordWithMedia(app.bsky.embed.RecordWithMedia)

        case viewImages(app.bsky.embed.Images.View)
        case viewExternal(app.bsky.embed.External.View)
        case viewRecord(app.bsky.embed.Record.View)
        case viewRecordWithMedia(app.bsky.embed.RecordWithMedia.View)

        public enum `Type`: String, Codable {
            case images = "app.bsky.embed.images"
            case external = "app.bsky.embed.external"
            case record = "app.bsky.embed.record"
            case recordWithMedia = "app.bsky.embed.recordWithMedia"

            case viewImages = "app.bsky.embed.images#view"
            case viewExternal = "app.bsky.embed.external#view"
            case viewRecord = "app.bsky.embed.record#view"
            case viewRecordWithMedia = "app.bsky.embed.recordWithMedia#view"
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decodeIfPresent(`Type`.self, forKey: .type)
            switch type {
            case .images:
                let data = try app.bsky.embed.Images(from: decoder)
                self = .images(data)
            case .external:
                let data = try app.bsky.embed.External(from: decoder)
                self = .external(data)
            case .record:
                let data = try app.bsky.embed.Record(from: decoder)
                self = .record(data)
            case .recordWithMedia:
                let data = try app.bsky.embed.RecordWithMedia(from: decoder)
                self = .recordWithMedia(data)
            case .viewImages:
                let data = try app.bsky.embed.Images.View(from: decoder)
                self = .viewImages(data)
            case .viewExternal:
                let data = try app.bsky.embed.External.View(from: decoder)
                self = .viewExternal(data)
            case .viewRecord:
                let data = try app.bsky.embed.Record.View(from: decoder)
                self = .viewRecord(data)
            case .viewRecordWithMedia:
                let data = try app.bsky.embed.RecordWithMedia.View(from: decoder)
                self = .viewRecordWithMedia(data)
            case .none:
                let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
                throw DecodingError.typeMismatch(Embed.self, error)
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .images(let data):
                try data.encode(to: encoder)
            case .external(let data):
                try data.encode(to: encoder)
            case .record(let data):
                try data.encode(to: encoder)
            case .recordWithMedia(let data):
                try data.encode(to: encoder)
            case .viewImages(let data):
                try data.encode(to: encoder)
            case .viewExternal(let data):
                try data.encode(to: encoder)
            case .viewRecord(let data):
                try data.encode(to: encoder)
            case .viewRecordWithMedia(let data):
                try data.encode(to: encoder)
            }
        }
    }
}
