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
    var colorController: ColorController?
    
    //MARK: - Outlets
    @IBOutlet weak var colorPickerView: UIPickerView!
    
    //MARK: - Methods
    func updateViews() {
        //Unwrapping
        guard let colorController = colorController else {
            print("Bad delegate or colorController in ThemePicker")
            return
        }
        
        colorPickerView.selectRow(colorController.currentColorIndex, inComponent: 0, animated: true)
        setBackgroundColor(index: colorController.currentColorIndex)
    }
    
    //Set Color
    func setBackgroundColor(index: Int) {
        
        //Unwrapping ColorController
        guard let colorController = colorController else {
            print("Couldn't unwrap colorController in ThemePickerViewController!")
            return
        }
    
        //Get Color
        let color = colorController.getUIColor(name: colorController.colorNames[index])
        colorController.saveCurrentColor(color: color, index: index)
        
        view.backgroundColor = color
        delegate?.navigationController?.navigationBar.barTintColor = color
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
        return colorController?.colorNames.count ?? 0
    }
    
    //Set Titles
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorController?.colorNames[row] ?? "Nil"
    }
    
    //Value Changed
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setBackgroundColor(index: row)
    }
    
}
