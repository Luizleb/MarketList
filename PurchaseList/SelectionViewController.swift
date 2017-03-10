//
//  SelectionViewController.swift
//  PurchaseList
//
//  Created by User on 09/03/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    var previousVC : MainViewController?
    
    var item : Item?
    
    @IBAction func itemDeleteButton(_ sender: Any) {
        let sharedDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = sharedDelegate.persistentContainer.viewContext
        context.delete(item!)
        sharedDelegate.saveContext()
        navigationController!.popViewController(animated: true)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        itemNameLabel.text = item?.name
    }
    
}
