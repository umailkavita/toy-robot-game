//
//  Toy_RobotTests.swift
//  Toy-RobotTests
//
//  Created by Kavita Mevada on 12/9/20.
//  Copyright © 2020 Kavita Mevada. All rights reserved.
//

import XCTest
@testable import Toy_Robot

class Toy_RobotTests: XCTestCase {
    var viewController: ViewController! = nil
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //Instantiating UIViewController with Storyboard ID
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        viewController.loadViewIfNeeded()
    }
    func testRobotNotOnTable() throws {
        let report = viewController.reportRobotPosition()
        XCTAssertNil(report);
    }
    
    func testRobotNotOnTableIgnoreOtherCommands() throws {
        viewController.moveForward(sender: UIButton());
        let report = viewController.reportRobotPosition()
        XCTAssertNil(report);
    }

    func testInitialPlacement() throws {
        viewController.placeRobot(sender: UIButton());
        let report = viewController.reportRobotPosition()
        XCTAssertEqual("Output: 0,0,NORTH", report)
    }
    
    func testMoveForward() throws {
        viewController.placeRobot(sender: UIButton());
        viewController.moveForward(sender: UIButton());
        let report = viewController.reportRobotPosition()
        XCTAssertEqual("Output: 0,1,NORTH", report)
    }
    
    func testTurnRight() throws {
        viewController.placeRobot(sender: UIButton());
        viewController.turnRight(sender: UIButton());
        let report = viewController.reportRobotPosition()
        XCTAssertEqual("Output: 0,0,EAST", report)
    }
    
    func testTurnLeft() throws {
        viewController.placeRobot(sender: UIButton());
        viewController.turnLeft(sender: UIButton());
        let report = viewController.reportRobotPosition()
        XCTAssertEqual("Output: 0,0,WEST", report)
    }
    
    func testRobotNotFallingFromTable() throws {
        viewController.placeRobot(sender: UIButton());
        viewController.turnLeft(sender: UIButton());
        viewController.moveForward(sender: UIButton());
        
        //the robot doesnt fall from west
        let report = viewController.reportRobotPosition()
        XCTAssertEqual("Output: 0,0,WEST", report)
    }
    
    func testRobotCanReceiveCommandAfterAvoidingFall() throws {
        viewController.placeRobot(sender: UIButton());
        viewController.turnLeft(sender: UIButton());
        viewController.moveForward(sender: UIButton());
        //the robot can still receive other commands
        viewController.turnRight(sender: UIButton());
        let report = viewController.reportRobotPosition()
        XCTAssertEqual("Output: 0,0,NORTH", report)
    }
}
