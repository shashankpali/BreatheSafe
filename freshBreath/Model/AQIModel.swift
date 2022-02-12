//
//  AQIModel.swift
//  freshBreath
//
//  Created by Shashank Pali on 12/02/22.
//

import Foundation

struct AQIModel: Codable
{
    var city : String
    var aqi : Double
}

enum AQIStatus {
    case good, satisfactory, moderate, poor, veryPoor, severe, unknown
    
    static func status(forAQI: Double) -> AQIStatus {
        switch forAQI {
        case 0...50: return .good
        case 50...100: return .satisfactory
        case 100...200: return .moderate
        case 200...300: return .poor
        case 300...400: return .veryPoor
        case 400...500: return .severe
        default: return .unknown
        }
    }
}
