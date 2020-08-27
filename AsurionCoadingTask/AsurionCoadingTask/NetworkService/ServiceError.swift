//
//  ServiceError.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 25/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import Foundation

/**
 An object containing an error with some additional context.
 */
public struct ServiceError {
    
    public init(type: ErrorType, cause: Error? = nil, message: String? = nil) {
        self.type = type
        self.cause = cause
        self.message = message
    }
    
    /**
     The enumorated type of error
     
     defaults to **defaultError**
     */
    public let type: ErrorType
    
    /**
     The original error that caused this error to be generated.
     */
    public let cause: Error?
    
    /**
     An optional message to give more context about the issue.
     */
    public let message: String?
}

/**
 An enum describing what went wrong.
 */
public enum ErrorType {
    
    // MARK: Decoding Errors
    
    /**
     A server response was received, but not in the expected format with the required data
     */
    case decodingError
    
    // MARK: Http Related Errors
    
    /**
     The downstream server encountered an internal error
     */
    case internalError
    
    /**
     The request was malformed
     */
    case badRequest
    
    /**
     The requested resource cannot be found
     */
    case notFound
    
    /**
     The request was either not made with authentication, or the user is not authorized to access the requested resource
     */
    case unauthorized
    
    /**
     The request was received, but the server has decided not to process it.
     */
    case forbidden
    
    // MARK: Timeout Errors
    /**
     The request has exceeded the client's max wait time.
     */
    case timedOut
    
    // MARK: No Internet
    /**
     The Internet connection appears to be offline.
     */
    case NoInternet
    
    // MARK: Unknown Error
    /**
     An unexpected error has occured such that the library was unable to classify it
     */
    case defaultError
    
    
    internal static func type(given statusCode: Int?) -> ErrorType {
        
        guard let statusCode = statusCode else {
            return .defaultError
        }
        
        switch statusCode {
        
        case 400: return .badRequest
        
        case 401: return .unauthorized
            
        case 403: return .forbidden
            
        case 404: return .notFound
        
        case 500: return .internalError
        
        default: return .defaultError
            
        }
    }

}

internal struct ConfigurationError: Error {
    
    let cause: String
    let message = "The Service library has been configured improperly"
}
