//
//  PetsCell.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 26/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import UIKit

class PetsCell: UITableViewCell {
    
    static let identifier: String = "petsCell"
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblPetName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initWithPetInfo(petInfo: PetInfo) {
        lblPetName.text = petInfo.title
        
        if let imgURL = petInfo.image_url {
            imgView.imageFromServerURL(urlString: imgURL, PlaceHolderImage: UIImage(named: "placeholderImage"))
        }
    }
}



