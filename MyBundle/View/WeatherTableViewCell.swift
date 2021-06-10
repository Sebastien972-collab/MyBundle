//
//  WeatherTableViewCell.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 02/05/2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var goToWeatherCityButton: UIButton!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var addToFavoris: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    private func addShadow() {
        whiteView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        whiteView.layer.shadowRadius = 2.0
        whiteView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        whiteView.layer.shadowOpacity = 2.0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func tappedGoToWeatherCityButton(_ sender: Any) {
    }
    
    func configure(title : String, subtitle : String, imageName : String, isFavorite : Bool) {
        titleLabel.text = title
        subTitleLabel.text = subtitle
        if #available(iOS 13.0, *) {
            iconImageView.image = UIImage(named: imageName) ?? UIImage(systemName: "cloud")
        } else {
            // Fallback on earlier versions
        }
        addToFavoris.isHidden = !isFavorite
    }
}
