//
//  ConfigModel.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 25/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import Foundation

struct Config: Codable {
    
    let isChatEnabled: Bool?
    let isCallEnabled: Bool?
    let workHours: String?
}

struct ConfigModel: Codable{
    let settings: Config
}
