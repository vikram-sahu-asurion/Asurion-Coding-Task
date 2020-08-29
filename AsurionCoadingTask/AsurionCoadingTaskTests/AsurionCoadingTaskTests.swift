//
//  AsurionCoadingTaskTests.swift
//  AsurionCoadingTaskTests
//
//  Created by Sahu, Vikram on 25/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import XCTest
@testable import AsurionCoadingTask

class AsurionCoadingTaskTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHasPetsListAvailable() {
        let expect = expectation(description: "expectation")
        
        NetworkManager.shared.fetchPetsData { (result) in
            switch result {
            case .success(domainModel:let petsModel):
                XCTAssertTrue(!petsModel.pets.isEmpty)
                expect.fulfill()
            case .failure(_):
               XCTFail()
            }
        }
        
        waitForExpectations(timeout: 2) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
          }
        }
    }
    
    func testCheckWorkingHoursAPI() {
        let expectedWorkHours = "M-F 9:00 - 18:00"
        
        let expect = expectation(description: "expectation")
        
        NetworkManager.shared.fetchConfig { (result) in
            switch result {
            case .success(domainModel: let config):
                XCTAssertEqual(config.settings.workHours, expectedWorkHours)
                expect.fulfill()
                
            case .failure(_):
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 2) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
          }
        }
    }
    
    func testCheckAvailabilityLogic() {
        // Test to check Week day availbility ... here the time will be start of week Monday 12:00 AM
        // Expected result false
        let thisMonday = Date().startOfWeek
        
        if let date = thisMonday {
            let mondayAvailability = checkForAvailbility(forDate: date)
            XCTAssertEqual(false, mondayAvailability)
        }
        
        // Test for week end Saturday or Sunday
        // Expected result false
        let thisSunday = Date().thisSunday
        
        if let date = thisSunday {
            let mondayAvailability = checkForAvailbility(forDate: date)
            XCTAssertEqual(false, mondayAvailability)
        }
        
        // Test to check for Monday between 9:00 to 18:00
        // Expected result true
        let dateInWorkingHour = Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: thisMonday ?? Date())!
        
        let mondayAvailability = checkForAvailbility(forDate: dateInWorkingHour)
        XCTAssertEqual(true, mondayAvailability)
        
    }
    
    func checkForAvailbility(forDate: Date) -> Bool {
        
        let workingHours = "M-F 9:00 - 18:00"
        
        var open = forDate
        var close = forDate
        
        let array = workingHours.components(separatedBy: " ")
        if array.count == 4 {
            let availableDays = array.first
            
            if availableDays == "M-F" {
                // If the current day is weekend (Saturday & Sunday) then it returns from the guard because the helpline is available for Monday to Friday
                guard !Calendar.current.isDateInWeekend(forDate) else {
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
                open = Calendar.current.date(bySettingHour: Int(openHour) ?? 0, minute: Int(openMin) ?? 0, second: 0, of: forDate)!
            }
            
            let closeHourMin = closeTimeAsString.components(separatedBy: ":")
            if closeHourMin.count == 2 {
                let closeHour = closeHourMin[0]
                let closeMin = closeHourMin[1]
                close = Calendar.current.date(bySettingHour: Int(closeHour) ?? 0, minute: Int(closeMin) ?? 0, second: 0, of: forDate)!
            }
            
            let isFallsInWorkingHours = forDate.isBetween(startDate: open, andEndDate: close)
            return isFallsInWorkingHours
        }
        return false
    }

}
