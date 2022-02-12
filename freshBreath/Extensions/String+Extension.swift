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
}
