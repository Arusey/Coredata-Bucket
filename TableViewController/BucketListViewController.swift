//
//  ViewController.swift
//  TableViewController
//
//  Created by Kevin Lagat on 12/12/2021.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController {
    
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cars = [Cars]()

    
    var array = ["Ferrari", "Mercedes", "Red Bull"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addTapped))
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllItems()
    }
    
    
    @objc func addTapped() {
        let addItemVC = storyboard?.instantiateViewController(withIdentifier: "add") as! AddItemViewController
        addItemVC.addItemDelegate = self
        self.navigationController?.pushViewController(addItemVC, animated: true)
    }
    
    
    func fetchAllItems() {
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cars")
        
        do {
            let result = try managedObjectContext.fetch(itemRequest)
            cars = result as! [Cars]
            
            for car in cars {
                print(car.name!)
                print("Success")
            }
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cars[indexPath.row].name
        return cell
    }
    


}

extension BucketListViewController: AddItemDelegate {
    func addItem(item: String) {
        
        let cars = NSEntityDescription.insertNewObject(forEntityName: "Cars", into: managedObjectContext) as! Cars
        
        cars.name = item
        
        guard let myCar = cars.name else { return }
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success \(myCar)")
            } catch {
                print("\(error.localizedDescription)")
            }
        }

    }

}
