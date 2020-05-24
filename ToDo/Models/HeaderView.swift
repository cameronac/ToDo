//
//  HeaderView.swift
//  ToDo
//
//  Created by Cameron Collins on 5/22/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    //MARK: - Properties
    var header: UITableViewHeaderFooterView? {
        willSet {
            //Unwrapping Header
            guard let value = newValue else {
                print("Bad header assigned in HeaderView!")
                return
            }
            
            //Unwrap Name
            guard let name = name else {
                return
            }
            
            setup(header: value, name: name)
        }
    }
    let button = UIButton()
    let label = UILabel()
    var name: String? = ""
    
    //MARK: - Initializer
    required init(name: String) {
        super.init(frame: CGRect.zero)
        self.name = name
        isUserInteractionEnabled = true
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    ///Sets up header view with buttons and label collapse indicator
    func setup(header: UITableViewHeaderFooterView, name: String) {
        
        //Set View Properties
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = CGRect(x: 0, y: 0, width: header.frame.width, height: header.frame.height)
        self.backgroundColor = UIColor.orange
        
        //Set Label Properties
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.text = "↓"
        label.frame = CGRect(x: header.frame.maxX * 0.92, y: 0, width: header.frame.width, height: header.frame.height)
        
        //Set Button Properties
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .center
        button.center = CGPoint(x: 0, y: 0)
        button.tintColor = UIColor.white
        button.setTitle("\(name)", for: .normal)
        button.frame = CGRect(x: 15, y: 0, width: header.frame.width, height: header.frame.height)
        button.isUserInteractionEnabled = true
        
        //Adding Views as Subviews
        header.addSubview(self)
        self.addSubview(label)
        self.addSubview(button)
        
        //Setting up View Contraints
        let viewXC = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: header, attribute: .leading, multiplier: 1.0, constant: 0)
        let viewYC = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: header, attribute: .trailing, multiplier: 1.0, constant: 0)
        let viewWC = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: header, attribute: .width, multiplier: 1.0, constant: 0)
        let viewHC = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: header, attribute: .height, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([viewXC, viewYC, viewWC, viewHC])
        
        
        //Setting up Button
        let buttonXC = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let buttonYC = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let buttonWC = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0)
        let buttonWH = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([buttonXC, buttonYC, buttonWC, buttonWH])
        
    }
    
    ///Reloads view by calling setNeedsDisplay
    func reload() {
        label.text = "It works!!"
        self.setNeedsDisplay()
    }
}
