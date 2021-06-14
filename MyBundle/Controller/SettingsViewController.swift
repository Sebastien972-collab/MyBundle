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
    let userDefault = UserDefaults.standard
    var citys =  City.shared.city
    override func viewDidLoad() {
        super.viewDidLoad()
        if !userDefault.bool(forKey: "fromEur") {
            deviseSegmentedControls.selectedSegmentIndex = 1
        }
        
    }
    @IBAction func tappedSaveSettings(_ sender: Any) {
        let deviceSelection = deviseSegmentedControls.selectedSegmentIndex
        if deviceSelection == 0 {
            userDefault.set(true, forKey: "fromEur")
        }else {
            userDefault.set(false, forKey: "fromEur")
        }
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
