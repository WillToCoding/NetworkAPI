//
//  NetworkError.swift
//  EmpleadosAPI
//
//  Created by Juan Carlos on 19/11/25.
//

import Foundation

public enum NetworkError: LocalizedError {
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case nonHTTP

    // Tiene que ser public, porque como forma parte del protocolo LocalizedError, al poner public la enumeración, la obligación del protocolo también tiene que ser public.
    public var errorDescription: String? {
        switch self {
        case .general(let error):
            error.localizedDescription
        case .status(let int):
            "HTTP status code: \(int)"
        case .json(let error):
            "JSON error: \(error)" // .localizedDescription
        case .dataNotValid:
            "Invalid data received from server"
        case .nonHTTP:
            "URLSession did not return an HTTPURLResponse"
        }
    }
}
