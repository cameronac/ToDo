//
//  CreateTaskViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Properties
    static let identifier = "createTaskSegue"
    var coreDataStack: CoreDataStack?
    var delegate: TaskTableViewController?
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: - Actions
    @IBAction func createTaskButtonPressed(_ sender: UIButton) {
        
        //Creating Task and Saving to CoreDataStack
        Task(title: titleTextField.text, bodyText: descriptionTextView.text, complete: false)
        
        //Save Task If we have the CoreDataStack Object
        if let tempCoreDataStack = coreDataStack {
            tempCoreDataStack.save()
        }
        
        delegate?.updateTableView()
        dismiss(animated: true, completion: nil)
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
