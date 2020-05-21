//
//  ThemePickerViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/20/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class ThemePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        
        updateViews()
    }
    
    //MARK: - Properties
    static let identifier = "colorSegue"
    var delegate: TaskTableViewController?
    var colorController = ColorController()
    
    //MARK: - Outlets
    @IBOutlet weak var colorPickerView: UIPickerView!
    
    //MARK: - Methods
    func updateViews() {
        //Unwrapping
        guard let delegate = delegate else {
            print("Bad delegate in ThemePicker")
            return
        }
        
        colorController.currentColor = delegate.color
    }
    
    //Set Color
    func setBackgroundColor(index: Int) {
        
        guard let color = colorController.colors[colorController.colorNames[index]] else {
            print("Color is nil!")
            return
        }
        
        view.backgroundColor = color
        delegate?.color = color
    }
}


//Picker View Methods
extension ThemePickerViewController {
    
    //Return Number of Sections/Components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Return Color Count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorController.colorNames.count
    }
    
    //Set Titles
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorController.colorNames[row]
    }
    
    //Value Changed
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setBackgroundColor(index: row)
    }
    
}
