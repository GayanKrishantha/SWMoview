// Created on 09/07/2022

import Foundation

extension String {
    var yyyMMddToDate: Date? {
        DateFormatter.yyyMMdd.date(from: self)
    }
    
    var yyyMMddttToDate: Date? {
        DateFormatter.fullMonthAndYear.date(from: self)
    }
}
