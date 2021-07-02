//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Syft on 05/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var capitalStackView: UIStackView!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var area: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func displayCountryData(name: String?, capital: String?, population: Int32,
                              region: String?, area: Double) {
        self.country.text = name
        //self.capital.text = capital
        
        if let capitalCity = capital, !capitalCity.isEmpty {
            self.capital.text = capitalCity
        }else{
            self.capitalLabel.isHidden = true
            capitalStackView.isHidden = true
        }
        
        self.population.text = Int(population).commaFormat
        
        self.area.text = "\(Int(area).commaFormat) km\u{00B2}"
        self.region.text = region
        
        
        self.accessibilityIdentifier = "\(name!)-Cell"
        self.country.accessibilityIdentifier = "Country"
        self.capital.accessibilityIdentifier = "\(name!)-Capital"
        self.capitalLabel.accessibilityIdentifier = "\(name!)-Capital-Label"
        self.population.accessibilityIdentifier = "\(name!)-Population"
        self.populationLabel.accessibilityIdentifier = "\(name!)-Population-Label"
        self.region.accessibilityIdentifier = "\(name!)-Region"
        self.regionLabel.accessibilityIdentifier = "\(name!)-Region-Label"
        
        self.area.accessibilityIdentifier = "\(name!)-Area"
        self.areaLabel.accessibilityIdentifier = "\(name!)-Area-Label"
    }
    
}


extension Int {
    
    private static var commaFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    
    var commaFormat: String {
        return Int.commaFormatter.string(from: NSNumber(value: self))!
    }
}
