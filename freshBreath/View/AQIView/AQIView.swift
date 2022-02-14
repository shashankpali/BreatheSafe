//
//  AQIView.swift
//  freshBreath
//
//  Created by Shashank Pali on 13/02/22.
//

import UIKit

final class AQIView: UIView {
    
    var contentView: UIView?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var updatedTimeLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var indexBackView: UIView!
    @IBOutlet weak var statusBackView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0).isActive = true
        
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AQIView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func prepare(forModel: CityModel) {
        cityNameLabel.text = forModel.name
        guard let record = forModel.records.last else {return}
        indexLabel.text = record.aqiString
        statusLabel.text = String.forStatus(record.status)
        updatedTimeLabel.text = "Updated " + String.forTime(record.time)
        
        let color = UIColor.forStatus(record.status)
        statusBackView.backgroundColor = color
        indexBackView.backgroundColor = color.withAlphaComponent(0.8)
    }
}
