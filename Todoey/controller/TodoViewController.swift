//
//  ViewController.swift
//  Todoey
//
//  Created by Prasad Zamre on 16/07/18.
//  Copyright © 2018 Prasad Zamre. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController {
    
    var itemArray = [Items]()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        

        
        
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
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        saveItems()
    
        tableView.deselectRow(at: indexPath, animated: true)
        
       
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            print("sucess")
            print(textField)
            
            let newitem = Items(context: self.context)
            newitem.title = textField.text!
            newitem.done = false
            newitem.parentCategory = self.selectedCategory
            
            
            
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
        
        
        do{
            try context.save()
        
            
            
        }
        catch{
            print("Error saving context")
            
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<Items> = Items.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
}

//MARK: - Search bar methods

extension TodoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}









