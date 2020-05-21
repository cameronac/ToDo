//
//  ThemePickerViewController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/20/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class ThemePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        
        updateViews()
    }
    
    //MARK: - Properties
    var currentColor: UIColor = UIColor.systemIndigo
    var colors: [String: UIColor] = ["Red": UIColor.systemRed, "Blue": UIColor.systemBlue, "Gray": UIColor.systemGray, "Pink": UIColor.systemPink, "Teal": UIColor.systemTeal, "Indigo": UIColor.systemIndigo, "Orange": UIColor.systemOrange, "Purple": UIColor.systemPurple, "Yellow": UIColor.systemYellow, "Green": UIColor.systemGreen]
    var colorNames: [String] = ["Red", "Blue", "Gray", "Pink", "Teal", "Indigo", "Orange", "Purple", "Yellow", "Green"]
    static let identifier = "colorSegue"
    var delegate: TaskTableViewController? 
    
    //MARK: - Outlet
    @IBOutlet weak var colorPickerView: UIPickerView!
    
    //MARK: - Methods
    func updateViews() {
        //Unwrap
        guard let delegate = delegate else {
            print("Bad delegate in ThemePicker")
            return
        }
        
        currentColor = delegate.color
    }
    
    //Set Color
    func setBackgroundColor(index: Int) {
        guard let color = colors[colorNames[index]] else {
            print("Color is nil!")
            return
        }
        
        view.backgroundColor = color
        delegate?.color = color
    }
    
    //Return Number of Sections/Components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Return Color Count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    //Set Titles
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorNames[row]
    }
    
    //Value Changed
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setBackgroundColor(index: row)
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
