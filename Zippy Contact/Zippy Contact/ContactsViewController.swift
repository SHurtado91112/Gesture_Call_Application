//
//  ContactsViewController.swift
//  Zippy Contact
//
//  Created by Andrei Gurau on 1/20/18.
//  Copyright © 2018 Steven Hurtado. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactsViewController: UITableViewController {
    
    var contacts = [CNContact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print("about to load data")
        loadData()
    }

    func loadData() {
        let keys = [CNContactPhoneNumbersKey, CNContactFormatter.descriptorForRequiredKeys(for: .fullName)] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        let contactStore = CNContactStore()
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                self.contacts.append(contact)
                
                print("tried to append contacts" )
                print(contact.givenName)
                print(contact.familyName)
                
                print(contact.phoneNumbers[0].value.stringValue)
            }
        }
        catch {
            print("unable to fetch contacts")
        }
        
        self.contacts.sort(by: { $0.givenName.lowercased() < $1.givenName.lowercased() })
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("grabbing self.contacts.count")
        print(self.contacts.count)
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {return ContactCell()}
        let contact = contacts[indexPath.row]
        //print(contact)
        print(indexPath.row)
        cell.nameLabel.text = "\(contact.givenName) \(contact.familyName)"
         //Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        
        let tel = contact.phoneNumbers[0].value.stringValue.removingWhitespaces()
        let candidate = Candidate(given: contact.givenName, fam: contact.familyName, num: tel)
        
        let alertController = UIAlertController(title: "Ready to train?", message: "If you say yes, you will be taken to a canvas page to write your new gesture for \(contact.givenName).", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "CanvasViewController") as? CanvasViewController {
                vc.trainingCandidate = candidate
                vc.training = true
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        let action2 = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
