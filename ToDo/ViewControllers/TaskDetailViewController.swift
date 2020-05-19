//
//  TaskDetailViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/12/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Properties
    static let identifier = "detailSegue"
    var coreDataStack: CoreDataStack?
    var task: Task?

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    
    //MARK: - Actions
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        //TODO
    }
    
    //MARK: - Functions
    func setupView() {
        //Unwrapping
        guard let task = task else {
            print("Task is nil in:  \(#file) \(#function) \(#line)")
            return
        }
        
        titleLabel.text = task.title
        descriptionTextView.text = task.bodyText
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
