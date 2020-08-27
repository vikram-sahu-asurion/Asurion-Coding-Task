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
    var configuration = Configuration()
    
    mutating func setPetsList(petsModel: PetsModel) {
        
        for petObj in petsModel.pets {
            var pet = Pet()
            pet.title = petObj.title ?? ""
            pet.image_url = petObj.image_url ?? ""
            pet.content_url = petObj.content_url ?? ""
            
            self.petsList.append(pet)
        }
    }
    
    mutating func setConfiguration(config: Config) {
        configuration.isChatEnabled = config.isChatEnabled ?? false
        configuration.isCallEnabled = config.isCallEnabled ?? false
        configuration.workHours = config.workHours ?? ""
    }
}

struct Pet {
    var image_url: String = ""
    var title: String = ""
    var content_url: String = ""
}

struct Configuration {
    var isChatEnabled: Bool = false
    var isCallEnabled: Bool = false
    var workHours: String = ""
}
