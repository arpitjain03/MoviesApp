//
//  String+Date.swift
//  MoviesApp
//
//  Created by Arpit Jain on 15/05/21.
//

import UIKit

extension String {
    
    func getDateAsAgo() -> String {
        
        let string = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: string) {
            let interval = Calendar.current.dateComponents([.year, .month, .day], from: date, to: Date())
            
            if let year = interval.year, year > 0 {
                return year == 1 ? "\(year)" + " " + "year ago" :
                    "\(year)" + " " + "years ago"
            } else if let month = interval.month, month > 0 {
                return month == 1 ? "\(month)" + " " + "month ago" :
                    "\(month)" + " " + "months ago"
            } else if let day = interval.day, day > 0 {
                return day == 1 ? "\(day)" + " " + "day ago" :
                    "\(day)" + " " + "days ago"
            } else {
                return "a moment ago"
            }
        } else {
            return self
        }
    }
}


