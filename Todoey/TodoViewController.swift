//
//  ViewController.swift
//  Todoey
//
//  Created by Prasad Zamre on 16/07/18.
//  Copyright © 2018 Prasad Zamre. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    var itemArray = ["Find iphone","Buy eggs","Buy chicken"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let item = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = item
        }
        
    }
    
    
    // table view datasource
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
        
    }
    
    // table view datasource
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
        
        
        
        
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            print("sucess")
            print(textField)
            
           self.itemArray.append(textField.text!)
            
            
            
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

