//
//  ViewModel.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 27/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import UIKit

struct PetsViewModel {
    
    var petsList = [Pet]()
    var configuration = Configuration(isChatEnabled: false, isCallEnabled: false, workHours: "")
    
    mutating func setPetsList(petsModel: PetsModel) {
        
        for petObj in petsModel.pets {
            let pet = Pet(image_url: petObj.image_url, title: petObj.title, content_url: petObj.content_url)
            self.petsList.append(pet)
        }
    }
    
    mutating func setConfiguration(config: Config) {
        configuration.isChatEnabled = config.isChatEnabled
        configuration.isCallEnabled = config.isCallEnabled
        configuration.workHours = config.workHours
    }
}

struct Pet {
    var image_url: String
    var title: String
    var content_url: String
}

struct Configuration {
    var isChatEnabled: Bool
    var isCallEnabled: Bool
    var workHours: String
}
