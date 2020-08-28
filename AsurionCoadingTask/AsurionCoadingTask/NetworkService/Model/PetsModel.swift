//
//  PetsModel.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 26/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import Foundation

struct PetInfo: Codable {
    
    let image_url: String
    let title: String
    let content_url: String
    let date_added: String
}

struct PetsModel: Codable{
    let pets: [PetInfo]
}
