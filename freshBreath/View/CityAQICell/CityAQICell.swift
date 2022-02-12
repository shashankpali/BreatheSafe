//
//  CityAQICell.swift
//  freshBreath
//
//  Created by Shashank Pali on 12/02/22.
//

import UIKit

class CityAQICell: UITableViewCell {

    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var updatedTimeLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var indexBackView: UIView!
    @IBOutlet weak var statusBackView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(forModel: CityModel) {
        cityNameLabel.text = forModel.name
        guard let record = forModel.records.last else {return}
        updatedTimeLabel.text = record.time.description
        indexLabel.text = record.aqiString
        let color = UIColor.color(forStatus: record.status)
        statusBackView.backgroundColor = color
        indexBackView.backgroundColor = color.withAlphaComponent(0.8)
    }
    
}
