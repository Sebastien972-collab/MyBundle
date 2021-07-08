//
//  LanguageTabViewCeTableViewCell.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 07/07/2021.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLanguage: UILabel!
    @IBOutlet weak var bcpcodeLanguageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(nameLanguage : String, bcpcodeLanguageLabel : String) {
        self.nameLanguage.text = nameLanguage
        self.bcpcodeLanguageLabel.text = bcpcodeLanguageLabel
        
//        addToFavoris.isHidden = !isFavorite
    }
}
