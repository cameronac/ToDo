//
//  ColorController.swift
//  ToDo
//
//  Created by Cameron Collins on 5/20/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit


class ColorController {
    
    //MARK: - Properties
    var currentColor: UIColor = UIColor.systemIndigo
    var currentColorIndex: Int = 5
    
    var colors: [String: UIColor] = ["Red": UIColor.systemRed, "Blue": UIColor.systemBlue, "Gray": UIColor.systemGray, "Pink": UIColor.systemPink, "Teal": UIColor.systemTeal, "Indigo": UIColor.systemIndigo, "Orange": UIColor.systemOrange, "Purple": UIColor.systemPurple, "Yellow": UIColor.systemYellow, "Green": UIColor.systemGreen]
    
    var colorNames: [String] = ["Red", "Blue", "Gray", "Pink", "Teal", "Indigo", "Orange", "Purple", "Yellow", "Green"]
    
    //MARK: - Methods
    func getUIColor(name: String) -> UIColor {
        let color = colors[name]
        
        //Unwrapping Color
        guard let tempColor = color else {
            print("Error while unwrapping color in ColorController")
            return UIColor.systemIndigo
        }
        
        return tempColor
    }
    
    //Saves Color Properties
    func saveCurrentColor(color: UIColor, index: Int) {
        currentColor = color
        currentColorIndex = index
    }
    
    func getSavedColor() -> UIColor {
        //TODO
        //return (5, UIColor.systemIndigo)
        return UIColor.systemIndigo
    }
}
