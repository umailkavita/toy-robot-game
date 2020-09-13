//
//  Constants.swift
//  Toy-Robot
//
//  Created by Kavita Mevada on 11/9/20.
//  Copyright © 2020 Kavita Mevada. All rights reserved.
//

import UIKit

//enum for robot's direction
enum Direction {
    case north, south, east ,west
}

//enum for robot's rotaion towards direction
enum RotationDirection {
    case left, right
}

//Default grid dimention in 5x5 units according to reqirements, but can change to any Int
let GridDimention:Int = 5

//Constant for Rotation in any direction (left or right) by 90 degrees
let M_PI_90 = CGFloat(Double.pi / 2)
