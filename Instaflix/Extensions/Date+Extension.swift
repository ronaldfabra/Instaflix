//
//  Date+Extension.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

import Foundation

extension Date {
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
}
