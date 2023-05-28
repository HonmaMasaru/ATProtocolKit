//
//  record.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension app.bsky.embed {
    /// A representation of a record embedded in another form of content
    struct Record: Codable {
        public let record: com.atproto.repo.StrongRef

        public struct View: Codable {
            public let record: ViewRecord
        }

        public struct ViewRecord: Codable {
            /// format: at-uri
            public let uri: String
            /// format: cid
            public let cid: String
            public let author: app.bsky.actor.defs.ProfileViewBasic?
            public let value: Value?
            public let labels: [com.atproto.label.defs.Label]?
            public let embeds: [ViewEmbed]?
            /// format: datetime
            public let indexedAt: String?
        }

        public struct ViewNotFound: Codable {
            /// format: at-uri
            public let uri: String
        }

        public struct ViewBlocked: Codable {
            /// format: at-uri
            public let uri: String
        }

        // TODO: 作業
        public struct Value: Codable {
        }
    }
}

// MARK: -

public enum RecordViewEmbed: Codable {
    case viewRecord(app.bsky.embed.Record.ViewRecord)
    case viewNotFound(app.bsky.embed.Record.ViewNotFound)
    case viewBlocked(app.bsky.embed.Record.ViewBlocked)

    private enum CodingKeys: String, CodingKey {
        case viewRecord, viewNotFound, viewBlocked
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        container.allKeys.forEach {
            print($0)
        }

        if container.contains(.viewRecord) {
            self = .viewRecord(try app.bsky.embed.Record.ViewRecord(from: decoder))
        }
        if container.contains(.viewNotFound) {
            self = .viewNotFound(try app.bsky.embed.Record.ViewNotFound(from: decoder))
        }
        if container.contains(.viewBlocked) {
            self = .viewBlocked(try app.bsky.embed.Record.ViewBlocked(from: decoder))
        }
        let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
        throw DecodingError.typeMismatch(RecordViewEmbed.self, error)
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .viewRecord(let data):
            try data.encode(to: encoder)
        case .viewNotFound(let data):
            try data.encode(to: encoder)
        case .viewBlocked(let data):
            try data.encode(to: encoder)
        }
    }
}
