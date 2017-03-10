//
//  AddViewController.swift
//  PurchaseList
//
//  Created by User on 08/03/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var supplierTextField: UITextField!
    @IBOutlet weak var importanceSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
        let sharedDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = sharedDelegate.persistentContainer.viewContext
        let item = Item(context: context)
        item.name = nameTextField.text
        item.supplier = supplierTextField.text
        item.importance = importanceSwitch.isOn
        item.createdAt = Date() as NSDate?

        sharedDelegate.saveContext()
        navigationController!.popViewController(animated: true)
    }
    
}
