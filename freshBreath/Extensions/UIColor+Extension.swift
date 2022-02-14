//
//  UIColor+Extension.swift
//  freshBreath
//
//  Created by Shashank Pali on 12/02/22.
//

import UIKit

extension UIColor {
    static func forStatus(_ status: AQIStatus) -> UIColor {
        return [.good : UIColor.init(red: 27/255, green: 120/255, blue: 55/255, alpha: 1),
                .satisfactory : UIColor.init(red: 90/255, green: 174/255, blue: 97/255, alpha: 1),
                .moderate : UIColor.init(red: 1, green: 204/255, blue: 0, alpha: 1),
                .poor : UIColor.init(red: 1, green: 147/255, blue: 0, alpha: 1),
                .veryPoor : UIColor.init(red: 1, green: 59/255, blue: 48/255, alpha: 1),
                .severe : UIColor.init(red: 179/255, green: 21/255, blue: 21/255, alpha: 1)][status] ?? .white
    }
}
