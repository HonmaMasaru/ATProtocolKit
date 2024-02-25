//
//  ATProtocolKit.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public enum StructureType: String, Codable {
    /// An XRPC "read" method (aka GET).
    case query
    /// An XRPC "modify" method (aka POST).
    case procedure
    /// An ATP repository record type.
    case record
    /// A declared identifier with no behaviors associated.
    case token
}

public protocol ATProtocolAPI {
    /// Request
    associatedtype APIRequest: ATProtocolRequest
    /// Response
    associatedtype APIResponse: ATProtocolResponse

    /// ID
    var id: String { get }
    /// Type
    var type: StructureType { get }
    /// Encoding
    var encoding: String? { get }
    /// Request
    var request: APIRequest { get set }
}

public extension ATProtocolAPI {
    /// リクエスト
    func request(host: String = "bsky.social", accessJwt: String? = nil, header: [String: String] = [:]) async throws -> APIResponse {
        let url = URL(string: "https://\(host)/xrpc/\(id)")!
        var urlRequest: URLRequest
        switch type {
        case .query:
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = request.queryItems
            guard let url = components?.url else { throw URLError(.badURL) }
            urlRequest = .init(url: url)
            urlRequest.httpMethod = "GET"
        case .procedure:
            urlRequest = .init(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = try JSONEncoder().encode(request)
        case .record, .token:
            throw URLError(.badURL)
        }
        if let encoding {
            urlRequest.addValue(encoding, forHTTPHeaderField: "Content-Type")
        }
        if let accessJwt {
            urlRequest.addValue("Bearer \(accessJwt)", forHTTPHeaderField: "Authorization")
        }
        header.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(APIResponse.self, from: data)
    }
}

public protocol ATProtocolRequest: Encodable {
}

public extension ATProtocolRequest {
    /// クエリーアイテム
    var queryItems: [URLQueryItem] {
        Mirror(reflecting: self).children.compactMap {
            guard let label = $0.label, let value = $0.value as? CustomStringConvertible else { return nil }
            return URLQueryItem(name: label, value: "\(value)")
        }
    }
}

public protocol ATProtocolResponse: Decodable, CustomDebugStringConvertible {
    var debugDescription: String { get }
}

public extension ATProtocolResponse {
    var debugDescription: String {
        let mirror = Mirror(reflecting: self)
        let children = mirror.children.map { "\($0.label!) = \($0.value)" }
        return children.joined(separator: ", ")
    }
}
