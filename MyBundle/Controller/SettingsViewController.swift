//
//  SettingsViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 26/05/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var deviseSegmentedControls: UISegmentedControl!
    @IBOutlet weak var langageSegmentedControls: UISegmentedControl!
    var row = 0
    
    var citys =  City.shared.city
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func tappedSaveSettings(_ sender: Any) {
    }
    
}
extension SettingsViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citys.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citys[row].city
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
    }

}
