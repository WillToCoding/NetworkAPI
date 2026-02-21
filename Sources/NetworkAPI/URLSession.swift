//
//  URLSession.swift
//  EmpleadosAPI
//
//  Created by Juan Carlos on 19/11/25.
//

import Foundation

extension URLSession {
    @available(iOS 17.0, macOS 14.0, *)
    public func getData(for request: URLRequest) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, httpResponse)
        } catch {
            throw .general(error)
        }
    }
}

