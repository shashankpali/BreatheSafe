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
    private var timer : Timer?
    private let ratio : Float = 1.4
    
    private lazy var arr : [DataEntry] = {
        guard let records = cityModel?.records else {return []}
        var arr = [DataEntry]()
        let max = records.max{$0.aqi > $1.aqi}!
        for rec in records {
            let val = Float(rec.aqi / max.aqi) / ratio
            arr += [DataEntry(color: UIColor.forStatus(rec.status), height: val, textValue: rec.aqiString, title: String.asMinAndSec(rec.time))]
        }
        return arr
    }()
    
    func build(forModel: CityModel?) {
        cityModel = forModel
        guard cityModel != nil else {return}
        getUpdate(inSeconds: nil, fromUI: false)
    }
    
    func getUpdate(inSeconds: Double?, fromUI: Bool) {
        timer?.invalidate()
        var ui = fromUI
        timer = Timer.scheduledTimer(withTimeInterval: inSeconds ?? 30.0, repeats: true) {[unowned self] (timer) in
            defer { ui = false }
            guard let records = cityModel?.records, !ui else {return}
            
            let max = records.max{$0.aqi > $1.aqi}!
            
            let rec = records.last!
            let val = Float(rec.aqi / max.aqi) / ratio
            arr += [DataEntry(color: UIColor.forStatus(rec.status), height: val, textValue: rec.aqiString, title: String.asMinAndSec(Date()))]
            
            delegate?.didUpdatedChart(model: cityModel!, data: arr)
        }
        timer?.fire()
    }
    
}
