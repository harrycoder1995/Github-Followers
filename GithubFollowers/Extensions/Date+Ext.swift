//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 09/05/24.
//

import Foundation

extension Date {
    
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
