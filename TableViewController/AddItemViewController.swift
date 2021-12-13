//
//  AddItemViewController.swift
//  TableViewController
//
//  Created by Kevin Lagat on 12/12/2021.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var bucketItem: UITextField!

    var addItemDelegate: AddItemDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.appendElement))


        // Do any additional setup after loading the view.
    }
    
    @objc func appendElement() {
        
        guard let item = bucketItem.text else { return }
        addItemDelegate?.addItem(item: item)
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


protocol AddItemDelegate: class {
    func addItem(item: String)
}
