//
//  SettingsViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 26/05/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak private  var deviseSegmentedControls: UISegmentedControl!
    @IBOutlet weak private var langageSegmentedControls: UISegmentedControl!
    @IBOutlet weak private var languagePreference: UIPickerView!
    private var row = 0
    private let userDefault = UserDefaults.standard
    private var languages =  LanguageAvailable.language
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !userDefault.bool(forKey: "fromEur") {
            deviseSegmentedControls.selectedSegmentIndex = 1
        }
        
    }
    @IBAction private func tappedSaveSettings(_ sender: Any) {
        
        let deviceSelection = deviseSegmentedControls.selectedSegmentIndex
        if deviceSelection == 0 {
            userDefault.set(true, forKey: "fromEur")
        }else {
            userDefault.set(false, forKey: "fromEur")
        }
        userDefault.set(row, forKey: "FavoriteLanguageRow")
    }
    
}
extension SettingsViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].langage
    }
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
    }

}
