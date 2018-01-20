//
//  ViewController.swift
//  Zippy Contact
//
//  Created by Andrei Gurau on 1/19/18.
//  Copyright © 2018 Andrei Gurau. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController:  UIViewController {
    var contacts = [CNContact]()
    @IBOutlet weak var tableView: UITableView!
    //var objects = [CNContact]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.

        if let url = URL(string: "tel://3057940656") {
            //print("tried to call")
            UIApplication.shared.openURL(url)
            //print("after call")
        }
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
        //self.getContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        if let contacts = contacts{
//            return contacts.count
//        }
//        else
//        {
//            return 0
//        }
//    }
    
//    @IBAction func callFriend(sender: AnyObject) {
//        var url:NSURL = NSURL(string: "tel://123456789")!
//        UIApplication.sharedApplication().openURL(url)
//        
//    }

}
