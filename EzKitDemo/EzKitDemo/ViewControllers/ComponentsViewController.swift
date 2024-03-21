//
//  ComponentsViewController.swift
//  EzKitDemo
//
//  Created by Dusan Dudukovic on 19.3.24..
//

import Foundation
import UIKit
import EzKit

class ComponentsViewController: UIViewController {
    
    @IBOutlet weak var ezButton: EzButton!
    @IBOutlet weak var imagesEzButton: EzButton!
    @IBOutlet weak var ezCheckbox: EzCheckbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ezButton.configure(button: .ez(cornerRadius: 6), titleText: "I am a button",
                           textColor: .white,
                           font: .boldSystemFont(ofSize: 16))
        ezButton.setupSubtitleLabel(text: "(with a subtitle)", textColor: .white)
        
        imagesEzButton.configure(button: .ezSecondary(buttonColor: .systemOrange, cornerRadius: 6),
                                 titleText: "I have images!",
                                 alignment: .left)
        imagesEzButton.setupLeftImageView(image: UIImage(systemName: "heart.fill"), tintColor: .systemRed)
        imagesEzButton.setupRightImageView(image: UIImage(systemName: "sun.max.fill"), tintColor: .systemYellow)
        
        ezCheckbox.configure(style: .main(selectedBorderColor: .systemGreen,
                                          selectedBackgroundColor: .systemGreen.withAlphaComponent(0.08),
                                          selectedCornerRadius: 22),
                             text: "I am a checkbox!", textColor: .systemGreen,
                             normalStateImage: UIImage(systemName: "circle")!,
                             selectedStateImage: UIImage(systemName: "checkmark.circle")!,
                             imageTintColor: .systemGreen)
        
        setupCallbacks()
    }
    
    private func setupCallbacks() {
        ezButton.onSelection = { _ in
            print("...or am I?")
        }
        
        imagesEzButton.onSelection = { [weak self] _ in
            self?.imagesEzButton.rightImageView.isHidden.toggle()
            self?.imagesEzButton.leftImageView.isHidden.toggle()
        }
        
        ezCheckbox.onSelection = { isSelected in
            print("ezCheckbox is", isSelected ? "selected" : "not selected")
        }
    }
    
}
