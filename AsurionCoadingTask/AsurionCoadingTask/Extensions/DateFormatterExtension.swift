//
//  DateFormatterExtension.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 27/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let format24hour : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}

extension Date {
    func isBetween(startDate date1: Date, andEndDate date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
}
