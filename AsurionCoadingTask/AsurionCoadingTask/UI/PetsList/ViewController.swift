//
//  ViewController.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 25/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // IBOutlets
    @IBOutlet weak var viewOfficeTiming: UIView!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var lblOfficeHours: UILabel!
    @IBOutlet weak var heightBtnChat: NSLayoutConstraint!
    @IBOutlet weak var heightBtnCall: NSLayoutConstraint!
    @IBOutlet weak var widthBtnChat: NSLayoutConstraint!
    @IBOutlet weak var widthBtnCall: NSLayoutConstraint!
    @IBOutlet weak var btnChatTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var btnCallLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    // Pets Array- this array will store the all list of pets from backend
    internal var petsArray = [PetInfo]() {
        didSet{
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }
    
    // working hours for clinic availability
    internal var workingHours = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        fetchDataFromServer()
    }
    
    // Initial UI Setup
    func setupUI() {
        // Set corner radius for call & chat button
        btnChat.layer.cornerRadius = 4
        btnCall.layer.cornerRadius = 4
        
        // Set border color & borderwidth for office hours view
        viewOfficeTiming.layer.borderWidth = 2
        viewOfficeTiming.layer.borderColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
    }
    
    // Backend Call to fetch the data
    func fetchDataFromServer() {
        NetworkManager.shared.fetchConfig { result in
            switch result {
            case .success(let configModel):
                DispatchQueue.main.async() {
                    self.setupConfiguration(config: configModel)
                }
                
            case.failure(error: let err):
                DispatchQueue.main.async() {
                    Utility.showAlertMessage(vc: self, titleStr: "Error", messageStr: err.message ?? "")
                }
            }
            
        }
        
        NetworkManager.shared.fetchPetsData { result in
            switch result {
            case .success(let petsModel):
                self.petsArray = petsModel.pets
                
            case.failure(error: let err):
                DispatchQueue.main.async() {
                    Utility.showAlertMessage(vc: self, titleStr: "Error", messageStr: err.message ?? "")
                }
            }
        }
    }
    
    func setupConfiguration(config: ConfigModel) {
        workingHours = config.settings.workHours ?? ""
        lblOfficeHours.text = "Office Hours: " + (config.settings.workHours ?? "")
        
        let isCallEnable = config.settings.isCallEnabled ?? false
        let isChatEnable = config.settings.isChatEnabled ?? false
        
        if (isChatEnable && isCallEnable) {
        // Both Call & Chat are enable
            btnCall.isHidden = false
            btnChat.isHidden = false
        }else if isChatEnable && !isCallEnable{
            // chat is enable & call is disable
            btnCall.isHidden = true
            btnChatTrailingSpace.constant = 22
            btnChatTrailingSpace.priority = UILayoutPriority(rawValue: 1000)
        }else if !isChatEnable && isCallEnable {
            btnChat.isHidden = true
            btnCallLeadingSpace.constant = 22
            btnCallLeadingSpace.priority = UILayoutPriority(rawValue: 1000)
        }else {
            // Both Call & Chat are disable
            btnCall.isHidden = true
            btnChat.isHidden = true
            headerView.frame = CGRect(x: headerView.frame.origin.x, y: headerView.frame.origin.y, width: headerView.frame.size.width, height: headerView.frame.size.height-100)
        }
        
        self.view.layoutIfNeeded()
    }
    
    func checkForAvailbility() -> Bool {
        
        var open = Date()
        var close = Date()
        
        let array = workingHours.components(separatedBy: " ")
        if array.count == 4 {
            let availableDays = array.first
            
            if availableDays == "M-F" {
                // If the current day is weekend (Saturday & Sunday) then it returns from the guard because the helpline is available for Monday to Friday
                guard !Calendar.current.isDateInWeekend(Date()) else {
                    return false
                }
            }
            
            // Now if current days is not a weekend then it will check for the time
            let openTimeAsString = array[1]
            let closeTimeAsString = array[3]
            
            let openHourMin = openTimeAsString.components(separatedBy: ":")
            if openHourMin.count == 2 {
                let openHour = openHourMin[0]
                let openMin = openHourMin[1]
                open = Calendar.current.date(bySettingHour: Int(openHour) ?? 0, minute: Int(openMin) ?? 0, second: 0, of: Date())!
            }
            
            let closeHourMin = closeTimeAsString.components(separatedBy: ":")
            if closeHourMin.count == 2 {
                let closeHour = openHourMin[0]
                let closeMin = openHourMin[1]
                close = Calendar.current.date(bySettingHour: Int(closeHour) ?? 0, minute: Int(closeMin) ?? 0, second: 0, of: Date())!
            }
            
            close = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!
            
            let isFallsInWorkingHours = Date().isBetween(startDate: open, andEndDate: close)
            return isFallsInWorkingHours
        }
        return false
    }
    
    // MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PetsCell.identifier) as? PetsCell {
            cell.initWithPetInfo(petInfo: petsArray[indexPath.row])
            return cell
        }
         
        return UITableViewCell()
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constant.segueToPetDetail, sender: petsArray[indexPath.row])
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected object to the new view controller.
        if segue.identifier == Constant.segueToPetDetail {
            let petInfo = sender as? PetInfo
            let destinationViewController = segue.destination as? PetDetailViewController
            destinationViewController?.petURL = petInfo?.content_url ?? ""
            destinationViewController?.petName = petInfo?.title ?? ""
        }
    }
    
    
    // MARK: - Actions of Char & Call Button
    
    @IBAction func chatAndCallAction(_ sender: Any) {
        if checkForAvailbility() {
            Utility.showAlertMessage(vc: self, titleStr: "Clinic Helpline", messageStr: Constant.workHourMsg)
        }else{
            Utility.showAlertMessage(vc: self, titleStr: "Clinic Helpline", messageStr: Constant.outsideWorkHourMsg)
        }
    }
    
}



