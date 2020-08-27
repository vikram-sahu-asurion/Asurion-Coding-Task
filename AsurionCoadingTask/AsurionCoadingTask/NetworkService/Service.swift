//
//  Service.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 25/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import UIKit

import Foundation

/**
 A generic service handler parameterized by domain & error models.
 
 - Parameter T: The domain model this service returns
 - Parameter E: The service error which is returned
 */

typealias ServiceCompletion<T, E> = (ServiceResult<T, E>) -> Void

typealias ConfigResponseCompletion<T: Codable> = ServiceCompletion<ConfigModel, ServiceError>
typealias PetsResponseCompletion<T: Codable> = ServiceCompletion<PetsModel, ServiceError>

enum ServiceResult<T, E> {
    
    /**
     Asserts that the service operation successfully completed.
     
     Contains a domain model
     */
    case success(domainModel: T)
    
    /**
     Asserts that the service operation failed for some reason.
     
     Contains an error model describing the failure.
     */
    case failure(error: E)
}
