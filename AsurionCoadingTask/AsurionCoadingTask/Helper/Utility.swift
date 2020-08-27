//
//  Utility.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 26/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    static func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }

}
