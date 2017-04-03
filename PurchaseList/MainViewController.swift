//
//  MainViewController.swift
//  PurchaseList
//
//  Created by User on 08/03/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mainTableView: UITableView!
    var itemArray : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let itemRequest : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            try itemArray = context.fetch(itemRequest)
        } catch {
            print(error)
        }
        mainTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "protCell", for: indexPath)
        let currentIndex = indexPath.row
        let currentItem = itemArray[currentIndex]
        if currentItem.importance {
            cell.textLabel?.text = "❗️\(currentItem.name!)"
        } else {
            cell.textLabel?.text = currentItem.name!
        }
        cell.detailTextLabel?.text = currentItem.supplier!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "deleteSegue", sender: itemArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "deleteSegue" {
            let nextVC = segue.destination as! SelectionViewController
            nextVC.item = sender as? Item
            nextVC.previousVC = self
        }
    }
}
