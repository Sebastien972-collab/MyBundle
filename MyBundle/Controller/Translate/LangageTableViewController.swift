//
//  LangageTableViewController.swift
//  MyBundle
//
//  Created by DAGUIN Sébastien on 07/07/2021.
//

import UIKit

class LangageTableViewController: UITableViewController {
    var langages = LanguageAvailable.language
    var fromLanguage = false
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return langages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as? LanguageTableViewCell else {
            return UITableViewCell()
        }

        // Configure the cell...
        cell.configure(nameLanguage: langages[indexPath.row].langage, bcpcodeLanguageLabel: langages[indexPath.row].bcpcode47)
        return cell
    }
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
//       performSegue(withIdentifier: "showLanguage", sender: self)
        dismiss(animated: true, completion: nil )
    }
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TranslateViewController {
            switch fromLanguage {
            case true:
                destination.fromLangage = langages[index]
            default:
                destination.toLangage = langages[index]
            }
        }
    }
}
