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

    func initWithPetInfo(petInfo: Pet) {
        lblPetName.text = petInfo.title
        
        if !petInfo.image_url.isEmpty {
            imgView.imageFromServerURL(urlString: petInfo.image_url, PlaceHolderImage: UIImage(named: "placeholderImage"))
        }
    }
}



