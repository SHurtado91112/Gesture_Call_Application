//
//  SettingsViewController.swift
//  Zippy Contact
//
//  Created by Andrei Gurau on 1/20/18.
//  Copyright © 2018 Steven Hurtado. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        
        self.setNav()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setNav() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeSettings))
    }

    @objc func closeSettings() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 1) {
            let alertController = UIAlertController(title: "Are you sure?", message: "If you say yes, you will erase all GESTURES associated to your contacts. Don't worry, it won't affect your actual list of contacts.", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
                    //use to clear data
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    UserDefaults.standard.synchronize()
            }
            
            let action2 = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
            }
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
