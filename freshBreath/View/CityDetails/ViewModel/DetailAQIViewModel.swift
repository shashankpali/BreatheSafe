//
//  DetailAQIViewModel.swift
//  freshBreath
//
//  Created by Shashank Pali on 14/02/22.
//

import UIKit

protocol DetailAQIViewModelDelegate {
    func didUpdatedChart(model: CityModel, data: [DataEntry])
}

final class DetailAQIViewModel {
    
    var delegate : DetailAQIViewModelDelegate?
    
    private var cityModel: CityModel?
    private var timer = Timer()
    private let ratio : Float = 1.4
    
    func build(forModel: CityModel?) {
        cityModel = forModel
        guard cityModel != nil else {return}
        getUpdate(inSeconds: 5.0)
    }
    
    func getUpdate(inSeconds: Double) {
        timer.invalidate()
        
        var arr = loadHistory()
        timer = Timer.scheduledTimer(withTimeInterval: inSeconds, repeats: true) {[unowned self] (timer) in
            guard let records = cityModel?.records else {return}
            
            let max = records.max{$0.aqi > $1.aqi}!
            
            let rec = records.last!
            let val = Float(rec.aqi / max.aqi) / ratio
            arr += [DataEntry(color: UIColor.forStatus(rec.status), height: val, textValue: rec.aqiString, title: String.asMinAndSec(Date()))]
            
            delegate?.didUpdatedChart(model: cityModel!, data: arr)
        }
        
        timer.fire()
    }
    
    private func loadHistory() -> [DataEntry] {
        guard let records = cityModel?.records else {return []}
        var arr = [DataEntry]()
        let max = records.max{$0.aqi > $1.aqi}!
        for rec in records {
            let val = Float(rec.aqi / max.aqi) / ratio
            arr += [DataEntry(color: UIColor.forStatus(rec.status), height: val, textValue: rec.aqiString, title: String.asMinAndSec(rec.time))]
        }
        return arr
    }
    
}
