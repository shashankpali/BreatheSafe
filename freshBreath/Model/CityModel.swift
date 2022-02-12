//
//  CityModel.swift
//  freshBreath
//
//  Created by Shashank Pali on 12/02/22.
//

import Foundation

class CityModel
{
    var name : String
    var records : [AQICityRecord]
    
    init(_ name: String, record: AQICityRecord) {
        self.name = name
        self.records = [record]
    }
    
    func update(record: AQICityRecord) {
        self.records += [record]
    }
}

struct AQICityRecord
{
    var aqi : Double
    var aqiString: String
    var time : Date
    
    init(_ model: AQIModel) {
        self.aqi = model.aqi
        self.aqiString = String(format: "%.2f", model.aqi)
        self.time = Date()
    }
}
