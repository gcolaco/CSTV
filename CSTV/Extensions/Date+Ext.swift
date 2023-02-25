//
//  Date+Ext.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import Foundation

extension Date {
    
    func convertToDayHourFormat() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "EEE, HH:mm"
        
        return dateFormatter.string(from: self)
    }
    
}
