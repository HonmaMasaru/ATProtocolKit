//
//  createSession.swift
//  ATProtocolKit
//
//  Created by Honma Masaru on 2023/05/20.
//

import Foundation

public extension com.atproto.server {

    struct createSession: ATProtocolAPI {
        /// Request
        public typealias APIRequest = Request
        /// Response
        public typealias APIResponse = Response

        /// ID
        public let id: String = "com.atproto.server.createSession"
        /// Type
        public let type: StructureType = .procedure
        /// Encoding
        public let encoding: String? = "application/json"
        /// Request
        public var request: Request

        public init(identifier: String, password: String) {
            request = .init(identifier: identifier, password: password)
        }

        /// Create an authentication session.
        public struct Request: ATProtocolRequest {
            /// Handle or other identifier supported by the server for the authenticating user.
            public let identifier: String

            /// Password
            public let password: String

            init(identifier: String, password: String) {
                self.identifier = identifier
                self.password = password
            }
        }

        /// Create an authentication session.
        public struct Response: ATProtocolResponse {
            /// accessJwt
            public let accessJwt: String

            /// refreshJwt
            public let refreshJwt: String

            /// - Note: format = handle
            public let handle: String

            /// - Note: format = did
            public let did: String

            /// email
            public let email: String?
        }
    }
}
