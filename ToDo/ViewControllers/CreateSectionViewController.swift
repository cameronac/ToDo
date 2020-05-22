//
//  CreateSectionViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/22/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class CreateSectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Properties
    var delegate: TaskTableViewController?
    static let identifier = "createSectionSegue"
    
    //MARK: - Outlets
    @IBOutlet weak var sectionTextField: UITextField!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        //Unwrapping TextField.text
        guard let text = sectionTextField.text else {
            print("SectionTextField nil when creating section")
            return
        }
        
        delegate?.taskController.createASection(name: text)
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
