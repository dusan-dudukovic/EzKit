//
//  EzCheckbox.swift
//
//
//  Created by Dusan Dudukovic on 19.3.24..
//

import Foundation
import UIKit

public class EzCheckbox: EzView {
    
    public var normalStateImage: UIImage?
    public var selectedStateImage: UIImage?
    
    public let imageView = UIImageView()
    public let titleLabel = UILabel()
    public let stackView = UIStackView()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    /// Configure `EzCheckbox` with `EzViewStyle`.
    ///
    /// You can also use `setupLabel` and `setupImages` functions separately.
    public func configure(style: EzViewStyle, text: String?, textColor: UIColor,
                          font: UIFont = .systemFont(ofSize: 16),
                          alignment: NSTextAlignment = .left,
                          normalStateImage: UIImage?,
                          selectedStateImage: UIImage?,
                          imageTintColor: UIColor?) {
        configure(configuration: style.generateConfiguration())
        
        setupLabel(text: text, textColor: textColor, font: font, alignment: alignment)
        setupImages(normalStateImage: normalStateImage, selectedStateImage: selectedStateImage, imageTintColor: imageTintColor)
        
        updateUI()
    }
    
    /// Setup label separately if needed.
    public func setupLabel(text: String?, textColor: UIColor,
                           font: UIFont = .systemFont(ofSize: 16),
                           alignment: NSTextAlignment = .center) {
        titleLabel.text = text
        titleLabel.textColor = textColor
        titleLabel.font = font
        titleLabel.textAlignment = alignment
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
    }
    
    /// Setup images separately if needed.
    public func setupImages(normalStateImage: UIImage?, selectedStateImage: UIImage?, imageTintColor: UIColor?) {
        self.normalStateImage = normalStateImage
        self.selectedStateImage = selectedStateImage
        imageView.tintColor = imageTintColor
    }
    
    public override func updateUI() {
        super.updateUI()
        
        imageView.image = isSelected ? selectedStateImage : normalStateImage
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
