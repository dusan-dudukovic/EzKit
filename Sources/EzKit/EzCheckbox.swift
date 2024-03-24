//
//  EzCheckbox.swift
//
//
//  Created by Dusan Dudukovic on 19.3.24..
//

import Foundation
import UIKit

public class EzCheckbox: EzView {
    
    public let imageView = UIImageView()
    public let titleLabel = UILabel()
    public let stackView = UIStackView()
    
    public var normalTextColor: UIColor?
    public var selectedTextColor: UIColor?
    
    public var normalStateImage: UIImage?
    public var selectedStateImage: UIImage?
    
    public var normalImageTintColor: UIColor?
    public var selectedImageTintColor: UIColor?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    /// Configure `EzCheckbox` with `EzViewStyle`.
    /// - Parameters:
    ///     - normalImageTintColor: Tint applied to the `UIImageView.tintColor` in normal state. Needs a template image in order to work.
    ///     - selectedImageTintColor: Tint applied to the `UIImageView.tintColor` in selected state. Needs a template image in order to work.
    ///
    /// You can also use `setupLabel` and `setupImages` functions separately.
    public func configure(style: EzViewStyle, text: String?,
                          normalTextColor: UIColor = .label,
                          selectedTextColor: UIColor = .label,
                          font: UIFont = .systemFont(ofSize: 16),
                          alignment: NSTextAlignment = .left,
                          normalStateImage: UIImage? = nil,
                          selectedStateImage: UIImage? = nil,
                          normalImageTintColor: UIColor? = nil,
                          selectedImageTintColor: UIColor? = nil) {
        configure(configuration: style.generateConfiguration())
        
        setupLabel(text: text, normalTextColor: normalTextColor, selectedTextColor: selectedTextColor, font: font, alignment: alignment)
        setupImage(normalStateImage: normalStateImage, selectedStateImage: selectedStateImage, normalImageTintColor: normalImageTintColor, selectedImageTintColor: selectedImageTintColor)
        
        updateUI()
    }
    
    /// Setup label separately if needed.
    public func setupLabel(text: String?, 
                           normalTextColor: UIColor,
                           selectedTextColor: UIColor = .label,
                           font: UIFont = .systemFont(ofSize: 16),
                           alignment: NSTextAlignment = .center) {
        titleLabel.text = text
        titleLabel.textColor = normalTextColor
        titleLabel.font = font
        titleLabel.textAlignment = alignment
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        
        self.normalTextColor = normalTextColor
        self.selectedTextColor = selectedTextColor
    }
    
    /// Setup images separately if needed.
    public func setupImage(normalStateImage: UIImage?,
                           selectedStateImage: UIImage?,
                           normalImageTintColor: UIColor? = nil,
                           selectedImageTintColor: UIColor? = nil) {
        self.normalStateImage = normalStateImage
        self.selectedStateImage = selectedStateImage
        self.normalImageTintColor = normalImageTintColor
        self.selectedImageTintColor = selectedImageTintColor
    }
    
    public override func updateUI() {
        super.updateUI()
        
        titleLabel.textColor = isSelected ? selectedTextColor : normalTextColor
        imageView.image = isSelected ? selectedStateImage : normalStateImage
        imageView.tintColor = isSelected ? selectedImageTintColor : normalImageTintColor
    }
    
    private func setupViews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
    }
    
}
