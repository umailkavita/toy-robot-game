//
//  UnitCell.swift
//  Toy-Robot
//
//  Created by Kavita Mevada on 11/9/20.
//  Copyright © 2020 Kavita Mevada. All rights reserved.
//

import UIKit
class UnitCell: UICollectionViewCell {
    
    // MARK: - Properties
    var robotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupCellLayout()
    }
}

// MARK: - Custom methods
extension UnitCell {
    func setupCellLayout() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.backgroundColor = UIColor.systemGray5.cgColor
        
        // Adds the robotImageView to the UnitCell so we can show/hide the robot's image
        contentView.addSubview(self.robotImageView)
        
        // Adding contraints of robotImageView = contentView and setting them as active
        self.robotImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.robotImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        self.robotImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        self.robotImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    func setAsOccupiedByRobot(occupied: Bool){
        if(occupied){
            // Adds robot from unit when unit is occupied
            self.robotImageView.image = UIImage(named: "robot")
        } else {
            // Removes robot from unit when unit is not occupied
            self.robotImageView.image = nil
        }
    }
}
