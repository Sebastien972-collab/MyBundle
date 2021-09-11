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
    }
    
}
