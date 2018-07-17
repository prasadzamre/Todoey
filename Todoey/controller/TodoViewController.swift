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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
      

        loadItems()
        

        
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
        
        
        return cell
        
        
    }
    
    // table view datasource
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
     
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
    
        
        
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
            
            
            self.saveItems()
            
           
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
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do{
            
            
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        }
        catch{
            print("Error encoding item")
            
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems(){
      
        
           if let data = try? Data(contentsOf: dataFilePath!) {
                let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Unable to decode")
            }
        }
    

    }
}

