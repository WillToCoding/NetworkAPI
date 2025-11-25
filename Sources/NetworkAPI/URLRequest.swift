//
//  URLRequest.swift
//  EmpleadosAPI
//
//  Created by Juan Carlos on 19/11/25.
//

import Foundation

extension URLRequest {
    public static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //request.setValue("Bearer lajsdñkjasdñlkjasñdlkj", forHTTPHeaderField: "Authorization")
        return request
    }
    
    public static func post<JSON>(url: URL, body: JSON, method: String = "POST") -> URLRequest where JSON: Codable {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 60
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        return request
    }
}
