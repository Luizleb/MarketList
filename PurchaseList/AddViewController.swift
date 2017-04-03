//
//  AddViewController.swift
//  PurchaseList
//
//  Created by User on 08/03/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var supplierTextField: UITextField!
    @IBOutlet weak var importanceSwitch: UISwitch!
    var basicList : [(name : String, supplier: String)] = [
        (name : "Energético", supplier : "Red Bull"),
        (name : "Suco de Maracujá", supplier : "Maguary"),
        (name : "Congelados Diversos", supplier : "Qualquer"),
        (name : "Pão de Forma", supplier : "Qualquer"),
        (name : "Presunto", supplier : "Qualquer"),
        (name : "Queijo", supplier : "Serro"),
        (name : "Requeijão", supplier : "Catupiry"),
        (name : "Castanha", supplier : "Qualquer"),
        (name : "Amendoim", supplier : "Qualquer")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func basicListTapped(_ sender: Any) {
        let sharedDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = sharedDelegate.persistentContainer.viewContext
        //delete the existent records
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        do {
            try context.execute(batchDeleteRequest)
            context.reset()
        } catch {
            let error = error as NSError
            print("\(error), \(error.userInfo)")
        }
        // insert the basic list
        for listItem in basicList {
            let item = Item(context: context)
            item.name = listItem.name
            item.supplier = listItem.supplier
            item.importance = true
            item.createdAt = Date() as NSDate?
            sharedDelegate.saveContext()
            navigationController!.popViewController(animated: true)
        }
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
