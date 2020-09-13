//
//  PrimaryButton.swift
//  Toy-Robot
//
//  Created by Kavita Mevada on 11/9/20.
//  Copyright © 2020 Kavita Mevada. All rights reserved.
//
import UIKit
@IBDesignable class PrimaryButton: UIButton {
    
    // MARK: - Properties
    // Allows to set the button color cutom property from storyboard
    @IBInspectable var buttonColor: UIColor = .black {
        didSet {
            self.layer.borderColor = self.buttonColor.cgColor
            self.layer.backgroundColor = self.buttonColor.cgColor
        }
    }
    
    // Overrides value to set alpha to 50% when not enabled
    open override var isEnabled: Bool{
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    override func prepareForInterfaceBuilder() {
        setupButton()
    }
}

// MARK: - Custom methods
extension PrimaryButton {
    func setupButton() {
        let spacing: CGFloat = 5.0
        self.contentEdgeInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing*2)
        self.layer.cornerRadius = spacing
        self.layer.borderWidth = 1.0
        self.sizeToFit()
    }
}

