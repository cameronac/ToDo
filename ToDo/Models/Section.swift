//
//  Section.swift
//  ToDo
//
//  Created by Cameron Collins on 5/21/20.
//  Copyright © 2020 iOS BW. All rights reserved.
//

import UIKit

class Section {
    
    //MARK: - Properties
    var name: String
    var isCollapsed: Bool
    var tasks: [Task?]
    var isViewSet: Bool = false
    var delegate: TaskTableViewController
    var viewColor: UIColor = UIColor.systemGray {
        willSet {
            guard let view = view else {
                print("Bad View when trying to assign color! \(#file) \(#function) \(#line)")
                return
            }
            
            view.backgroundColor = newValue
        }
    }
    var colorIndex = 0
    var sectionIndex: Int {
        willSet {
        //Adding Button Tags
        button.tag = newValue
        colorButton.tag = newValue
        deleteButton.tag = newValue
        }
    }
    
    //Created Objects
    var view: UIView? = nil
    let label = UILabel()
    let button = UIButton()
    let colorButton = UIButton()
    let deleteButton = UIButton()
    let stackView = UIStackView()
    
    //MARK: - Initializer
    init(name: String, tasks: [Task], isCollapsed: Bool = false, taskTableView: TaskTableViewController, sectionIndex: Int) {
        self.name = name
        self.tasks = tasks
        self.isCollapsed = isCollapsed
        self.delegate = taskTableView
        self.sectionIndex = sectionIndex
        self.setupView()
    }
    
    //MARK: - Methods
    ///Sets up the header view with the appropriate colors and buttons in a stackView
    private func setupView() {
    
        //Create View
        view = UIView(frame: CGRect(x: 0, y: 0, width: delegate.tableView.frame.width, height: TaskTableViewController.headerHeight))
        
        //Unwrapping
        guard let view = view else {
            print("Bad View in Section!")
            return
        }
        
        //Setting Up Properties
        view.backgroundColor = viewColor
        
        //Set StackView Properties
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(colorButton)
        stackView.addArrangedSubview(deleteButton)
        
        //Set Button Properties
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("\(name)", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.isUserInteractionEnabled = true
        
        //Set ColorButton
        colorButton.setTitle("", for: .normal)
        colorButton.setImage(UIImage(systemName: "paintbrush.fill"), for: .normal)
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.tintColor = UIColor.white
        colorButton.isUserInteractionEnabled = true
        
        //Set DeleteButton
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.tintColor = UIColor.white
        deleteButton.isUserInteractionEnabled = true
        
        view.addSubview(stackView)
        
        //Setting up Button Constraints
        let stackViewXC = NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        let stackViewYC = NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let stackViewWC = NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0)
        let stackViewWH = NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([stackViewXC, stackViewYC, stackViewWC, stackViewWH])
        
        //Setting up Button Constraints
        let buttonXC = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: stackView, attribute: .leading, multiplier: 1.0, constant: 15)
        
        NSLayoutConstraint.activate([buttonXC])
        
        //Setting up colorButton Constraints
        let colorButtonWH = NSLayoutConstraint(item: colorButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 50)
        
        NSLayoutConstraint.activate([colorButtonWH])
        
        //Setting up deleteButton Constraints
        let deleteButtonWH = NSLayoutConstraint(item: deleteButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 50)
        
        NSLayoutConstraint.activate([deleteButtonWH])
        
        //Adding Target
        button.addTarget(delegate, action: #selector(delegate.sectionButtonPressed(sender:)), for: .touchUpInside)
        colorButton.addTarget(delegate, action: #selector(delegate.sectionColorButtonPressed(sender:)), for: .touchUpInside)
        deleteButton.addTarget(delegate, action: #selector(delegate.sectionDeleteButtonPressed(sender:)), for: .touchUpInside)
        isViewSet = true
    }
    
}
