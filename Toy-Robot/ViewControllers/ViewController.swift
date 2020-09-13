//
//  ViewController.swift
//  Toy-Robot
//
//  Created by Kavita Mevada on 11/9/20.
//  Copyright © 2020 Kavita Mevada. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    // MARK: - Properties
    private let reuseIdentifier = "unitCell"
    private var selectedIndexPath: IndexPath?{
        didSet {
            // Sets place button as visible/invisible and other action buttons as enabled/disabled based on the robot's position
            if selectedIndexPath != nil {
                self.placeButton.isHidden = true
                self.rotateLeftButton.isEnabled = true
                self.rotateRightButton.isEnabled = true
                self.moveForwardButton.isEnabled = true
                self.reportButton.isEnabled = true
            } else {
                self.placeButton.isHidden = false
                self.rotateLeftButton.isEnabled = false
                self.rotateRightButton.isEnabled = false
                self.moveForwardButton.isEnabled = false
                self.reportButton.isEnabled = false
                
            }
        }
    }
    
    // The robot is initially facing north
    private var currentDirection: Direction = .north
    // The robot's initial rotation angle is 0
    private var currentAngle: CGAffineTransform = CGAffineTransform(rotationAngle: 0)
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var placeButton: PrimaryButton!
    @IBOutlet weak var rotateLeftButton: PrimaryButton!
    @IBOutlet weak var rotateRightButton: PrimaryButton!
    @IBOutlet weak var moveForwardButton: PrimaryButton!
    @IBOutlet weak var reportButton: PrimaryButton!
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Does any additional setup after loading the view
        self.setupView()
    }
    
    
}

// MARK: - Custom methods
extension ViewController {
    func setupView() {
        // As the robot is initially not visible, sets place button as visible and other action buttons as disabled
        self.placeButton.isHidden = false
        self.rotateLeftButton.isEnabled = false
        self.rotateRightButton.isEnabled = false
        self.moveForwardButton.isEnabled = false
        self.reportButton.isEnabled = false
        self.collectionView.register(UnitCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
}
// MARK: - Move to Direction methods
extension ViewController {
    func directionChanged(){
        // Calcules robot's current angle to find out its current direction
        let radians = atan2f(Float(self.currentAngle.b), Float(self.currentAngle.a));
        let degrees = round(radians * 180 / .pi)
        // As the robot is initially facing north, +90 is the left direction, -90 is the right direction and -180/+180 is the south direction
        if (degrees == 90){
            self.currentDirection = .east
        } else if (degrees == -90){
            self.currentDirection = .west
        }else if (degrees == -180 || degrees == 180){
            self.currentDirection = .south
        } else {
            self.currentDirection = .north
        }
    }
    func moveToDirection(type:Direction)
    {
        guard let selectedIndexPath = self.selectedIndexPath else {
            // The indexpath is not set, the robot is probably not yet set on the table
            return
        }
        
        var rowValue = selectedIndexPath.row
        var sectionValue = selectedIndexPath.section
        switch type {
        case .west:
            rowValue = rowValue - 1
            break
        case .east:
            rowValue = rowValue + 1
            break
        case .north:
            sectionValue = sectionValue - 1
            break
        case .south:
            sectionValue = sectionValue + 1
            break
        }
        
        if rowValue < 0  || sectionValue < 0 || rowValue > GridDimention-1  || sectionValue > GridDimention-1 {
            return
        }
        
        self.selectedIndexPath = IndexPath(row: rowValue, section: sectionValue)
        self.collectionView.reloadData()
    }
}
// MARK: - IBActions
extension ViewController {
    @IBAction func placeRobot(sender: UIButton) {
        if (self.selectedIndexPath != nil) {
            return
        }
        self.selectedIndexPath = IndexPath(row: 0, section: GridDimention-1)
        self.collectionView.reloadItems(at: [self.selectedIndexPath!])
    }
    
    @IBAction func moveForward(sender: UIButton) {
        self.moveToDirection(type: self.currentDirection )
    }
    
    @IBAction func turnLeft(sender: UIButton) {
        guard let selectedIndexPath = self.selectedIndexPath else {
            // The indexpath is not set, probably robot is not yet set on table
            return
        }
        
        let newRotationAngle = self.currentAngle.rotated(by: -M_PI_90)
        self.currentAngle = newRotationAngle
        self.collectionView.reloadItems(at: [selectedIndexPath])
        self.directionChanged()
    }
    
    @IBAction func turnRight(sender: UIButton) {
        guard let selectedIndexPath = self.selectedIndexPath else {
            // The indexpath is not set, the robot is probably not yet set on the table
            return
        }
        
        let newRotationAngle = self.currentAngle.rotated(by: M_PI_90)
        self.currentAngle = newRotationAngle
        self.collectionView.reloadItems(at: [selectedIndexPath])
        self.directionChanged()
    }
    
    func reportRobotPosition() -> String? {
        guard let selectedIndexPath = self.selectedIndexPath else {
            // The indexpath is not set, the robot is probably not yet set on the table
            return nil
        }
        
        // As the origin starts from 0,0 (SOUTH WEST), the section calculation is reversed
        let positionY = GridDimention - selectedIndexPath.section - 1
        let positionX = selectedIndexPath.row
        var facingTo = ""
        switch currentDirection {
        case .west:
            facingTo = "WEST"
            break
        case .east:
            facingTo = "EAST"
            break
        case .south:
            facingTo = "SOUTH"
            break
        case .north:
            facingTo = "NORTH"
        }
        return String(format: "Output: %d,%d,%@", arguments: [positionX,positionY,facingTo])
    }
    @IBAction func reportAlert(sender: UIButton) {
        guard let report = reportRobotPosition() else {
            // The indexpath is not set, the robot is probably not yet set on the table
            return
        }
        // Reports the current position in an alert view
        let alertViewController = UIAlertController(title: "Alert", message: report, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
        }
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    @IBAction func resetToyRobotGame(sender: UIButton) {
        // Clears robot's position to reset view
        self.selectedIndexPath = nil
        self.currentDirection = .north
        // Set robot's initial rotation angle to 0
        self.currentAngle = CGAffineTransform(rotationAngle: 0)
        // Once the position is cleared, the robot will get removed from the table
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource methods
extension ViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return GridDimention
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GridDimention
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Reusable UnitCell on the table
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UnitCell
        cell.robotImageView.transform = currentAngle
        var isOccupiedByRobot = false // Initially set robot is not there on current unit
        if let selectedIndexPath = self.selectedIndexPath, indexPath.row == selectedIndexPath.row && indexPath.section == selectedIndexPath.section {
            // Sets the unit as occupied by the robot as the robot's location is the current unit location
            isOccupiedByRobot = true
        }
        cell.setAsOccupiedByRobot(occupied: isOccupiedByRobot)
        return cell
    }
}

// MARK: - UICollectionViewDelegate FlowLayout methods
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculates the unit size according to the gridDimention, to equally divide units on table
        let mainViewWidth = collectionView.frame.width
        let cellViewWidth = CGFloat(mainViewWidth) / CGFloat (GridDimention)
        (collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: cellViewWidth, height: cellViewWidth)
        return CGSize(width: cellViewWidth, height: cellViewWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // No spacing between units
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // No spacing between units
        return 0.0
    }
    
}
