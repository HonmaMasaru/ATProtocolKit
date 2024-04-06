//
//  facet.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2024/04/06.
//

import Foundation

import Foundation

public extension app.bsky.richtext {
    /// Annotation of a sub-string within rich text.
    struct Facet: Codable {
        let features: [Feature]
        let index: ByteSlice
    }

    enum Feature: Codable {
        case mention(Mention)
        case link(Link)
        case tag(Tag)
        case byteSlice(ByteSlice)

        public enum `Type`: String, Codable {
            case mention = "app.bsky.richtext.facet#mention"
            case link = "app.bsky.richtext.facet#link"
            case tag = "app.bsky.richtext.facet#tag"
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decodeIfPresent(`Type`.self, forKey: .type)
            switch type {
            case .mention:
                let data = try Mention(from: decoder)
                self = .mention(data)
            case .link:
                let data = try Link(from: decoder)
                self = .link(data)
            case .tag:
                let data = try Tag(from: decoder)
                self = .tag(data)
            case .none:
                let error = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type encountered for Resource.")
                throw DecodingError.typeMismatch(app.bsky.embed.Embed.self, error)
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .mention(let data):
                try data.encode(to: encoder)
            case .link(let data):
                try data.encode(to: encoder)
            case .tag(let data):
                try data.encode(to: encoder)
            case .byteSlice(let data):
                try data.encode(to: encoder)
            }
        }
    }

    /// Facet feature for mention of another account. The text is usually a handle, including a '@' prefix, but the facet reference is a DID.
    struct Mention: Codable {
        /// format: did
        let did: String
    }

    /// Facet feature for a URL. The text URL may have been simplified or truncated, but the facet reference should be a complete URL.
    struct Link: Codable {
        /// format: uri
        let uri: String
    }
    
    /// Facet feature for a hashtag. The text usually includes a '#' prefix, but the facet reference should not (except in the case of 'double hash tags').
    struct Tag: Codable {
        /// maxLength: 640, maxGraphemes: 64
        let tag: String
    }
    
    /// Specifies the sub-string range a facet feature applies to. Start index is inclusive, end index is exclusive. Indices are zero-indexed, counting bytes of the UTF-8 encoded text. NOTE: some languages, like Javascript, use UTF-16 or Unicode codepoints for string slice indexing; in these languages, convert to byte arrays before working with facets.
    struct ByteSlice: Codable {
        /// minimum: 0
        let byteStart: Int
        /// minimum: 0
        let byteEnd: Int
    }
}
