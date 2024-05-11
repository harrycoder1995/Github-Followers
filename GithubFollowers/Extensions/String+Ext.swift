//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 09/05/24.
//

import Foundation

extension String {
    func convertToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.date(from: self) ?? Date()
    }
}
