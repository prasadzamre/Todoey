//
//  ViewController1TableViewController.swift
//  Todoey
//
//  Created by Prasad Zamre on 17/07/18.
//  Copyright © 2018 Prasad Zamre. All rights reserved.
//

import UIKit
import CoreData

class ViewController1TableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateData()

       
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert  = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add category", style: .default) { (action) in
            print("Sucess")
            
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.add()
            
            self.tableView.reloadData()
            
            
        }
        
        
        alert.addTextField { (textField1) in
            textField1.placeholder = "Enter new Category"
            textField = textField1
        }
        
        
        
        
        
        
        alert.addAction(alertAction)
        present(alert,animated: true,completion: nil)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let category = categoryArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToItem", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination as! TodoViewController
        
        if  let indexPath = tableView.indexPathForSelectedRow {
            destinationvc.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    func add(){
        do {
            try context.save()
        }
        catch{
            print("Error is saving data")
            
    }
    
    
    }
    
    func updateData(){
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            try  categoryArray  = context.fetch(request)
        }
        catch{
            print("Error in fetching data")
        }
        
        
    }
    
    
    
    
}
