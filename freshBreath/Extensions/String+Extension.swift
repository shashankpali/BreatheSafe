//
//  String+Extension.swift
//  freshBreath
//
//  Created by Shashank Pali on 13/02/22.
//

import Foundation

extension String {
    static func forStatus(_ status: AQIStatus) -> String {
        return [.good : "good",
                .satisfactory : "satisfactory",
                .moderate : "moderate",
                .poor : "poor",
                .veryPoor : "very poor",
                .severe : "severe"][status]?.uppercased() ?? ""
    }
    
    static func forTime(_ date: Date) -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: Date())
        
        guard ((interval.year ?? 0) + (interval.month ?? 0) + (interval.day ?? 0) + (interval.hour ?? 0)) < 1 else {
            let formatter = DateFormatter()
            if let day = interval.day, day > 0 {
                formatter.dateStyle = .long
                formatter.dateFormat = "'on' MMM dd, yy"
            }else {
                formatter.timeStyle = .medium
                formatter.dateFormat = "'on' hh:mm a"
            }
            let dateString = formatter.string(from: date)
            return dateString
        }
        
        if let minute = interval.minute, minute > 0 {
            return minute < 3 ? "few minutes ago" : "\(minute)" + " " + "minutes ago"
        }else if let second = interval.second, second > 1 {
            return "few seconds ago"
        } else {
            return "just now"
        }
    }
    
    static func asMinAndSec(_ date: Date) -> String {
        let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateFormat = "HH:mm:ss"
        
        let dateString = formatter.string(from: date)
        return dateString
    }
}
