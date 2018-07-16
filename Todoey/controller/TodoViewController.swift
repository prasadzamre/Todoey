//
//  ViewController.swift
//  Todoey
//
//  Created by Prasad Zamre on 16/07/18.
//  Copyright © 2018 Prasad Zamre. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let newItem = Item()
        newItem.title = "Find Mike"
        newItem.done = true
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Buy Iphone"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Read book"
        itemArray.append(newItem2)
        
        
        
        if let item = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = item
        }
        
    }
    
    
    // table view datasource
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let item = itemArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
//
        
        
        return cell
        
        
    }
    
    // table view datasource
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }
//        else{
//            itemArray[indexPath.row].done = false
//        }
        
        
        tableView.reloadData()
        
        
       
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
        
        
        
        
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            print("sucess")
            print(textField)
            
            
            let newitem = Item()
            newitem.title = textField.text!
            
            
           self.itemArray.append(newitem)
            
            
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            
           
            self.tableView.reloadData()
        
            
            
            
            
            
        }
        alert.addTextField { (alertText) in
            alertText.placeholder = "Create new item"
            print(alertText.text!)
            textField = alertText
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
    }
    


}

