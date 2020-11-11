//
//  DateFormatter.swift
//  TheNews
//
//  Created by Дарья on 12.11.2020.
//

import Foundation

extension DateFormatter {
    
    static let dateFormatFromXML: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        return formatter
    }()

    static let dateFormatForView: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
}
