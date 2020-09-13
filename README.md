# toy-robot-game

## Description

- This is an iOS application of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, and prevented from falling to destruction. However further valid movement commands are still be allowed.

## Commands

- PLACE : Places the robot on table at location (0,0) which is south west in this game, facing north.
- MOVE : Moves the robot one step forward towards the facing direction.
- ROTATE LEFT : Rotates the robot to the left of its current direction.
- ROTATE RIGHT : Rotates the robot to the right of its current direction.
- REPORT : Reports the current location of the robot and its faceing direction eg.(x,y,F).

## Architecture
The project is written in Swift 5, using Xcode 11.4.1. It runs on both iPad and iPhone, on portrait mode only.

## Instructions

### How to run
- Install Xcode 11.4.1
- Open `Toy-Robot.xcodeproj` in Xcode and wait for the indexing to finish.
- Build and Run the project from Xcode on iPad or iPhone simulator. I have used iPhone 11 Pro Max.

### Tests
- Tests are written in `Toy_RobotTests.swift` and you will have to manually run them from Test navigator.

### Logic
- I have used `UICollectionView` to easily create a 5 by 5 grid (table) for the robot to move on. This grid dimention is in the `GameConstants.swift` file which is customisable for any integer value. 
- I have left the grid markings for reference.
- On click of the *Place button*, the robot is placed at 0,0 location which is south west in this game.
- To turn left/right, I am rotating the robot by 90/-90 degrees respectively.
- On click of the *Report button*, `UIAlertController` is used to show the final results.
- The *Reset button* will reset the game to initial stage.
