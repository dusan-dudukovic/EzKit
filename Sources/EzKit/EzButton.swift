//
//  EzButton.swift
//
//
//  Created by Dusan Dudukovic on 19.3.24..
//

import Foundation
import UIKit

/// Highly flexible, animated button using the core benefits of `EzView`.
public class EzButton: EzView {
    
    // All of these are public so you can access them and tweak them if you want
    public let titleLabel = UILabel()
    public let subtitleLabel = UILabel()
    public let leftImageView = UIImageView()
    public let rightImageView = UIImageView()
    
    /// Main stack view.
    public let stackView = UIStackView()
    /// If for some reason you want to hide this stackView, make sure that EzView doesn't have required width constraint
    /// (should have less than 1000 priority).
    public let middleStackView = UIStackView()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    /// `EzButton` specific configuration function. Style is applied to `EzView` (superclass) and overrides it, while other parameters are applied to the `titleLabel`.
    ///
    /// Use setup functions to setup other elements - `setupSubtitleLabel`, `setupLeftImageView`, `setupRightImageView`.
    public func configure(button style: EzButtonStyle, titleText: String,
                          textColor: UIColor = .label,
                          font: UIFont = .systemFont(ofSize: 16),
                          alignment: NSTextAlignment = .center) {
        configure(configuration: style.generateConfiguration())
        
        setupTitleLabel(text: titleText, textColor: textColor, font: font, alignment: alignment)
    }
    
    /// Setup label separately if needed.
    public func setupTitleLabel(text: String, textColor: UIColor,
                                font: UIFont = .systemFont(ofSize: 16),
                                alignment: NSTextAlignment = .center) {
        titleLabel.text = text
        titleLabel.textColor = textColor
        titleLabel.font = font
        titleLabel.textAlignment = alignment
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.isHidden = text == ""
    }
    
    public func setupSubtitleLabel(text: String, textColor: UIColor,
                                   font: UIFont = .systemFont(ofSize: 16),
                                   alignment: NSTextAlignment = .center) {
        subtitleLabel.text = text
        subtitleLabel.textColor = textColor
        subtitleLabel.font = font
        subtitleLabel.textAlignment = alignment
        subtitleLabel.numberOfLines = 1
        subtitleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.isHidden = text == ""
    }
    
    public func setupLeftImageView(image: UIImage?, tintColor: UIColor? = nil) {
        leftImageView.image = image
        leftImageView.tintColor = tintColor
        leftImageView.isHidden = image == nil
    }
    
    public func setupRightImageView(image: UIImage?, tintColor: UIColor? = nil) {
        rightImageView.image = image
        rightImageView.tintColor = tintColor
        rightImageView.isHidden = image == nil
    }
    
    private func setupViews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
                
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        leftImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.addArrangedSubview(leftImageView)
        leftImageView.isHidden = leftImageView.image == nil
        
        middleStackView.axis = .vertical
        middleStackView.alignment = .fill
        middleStackView.distribution = .fill
        middleStackView.spacing = 0
        middleStackView.addArrangedSubview(titleLabel)
        middleStackView.addArrangedSubview(subtitleLabel)
        
        stackView.addArrangedSubview(middleStackView)
        
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        rightImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.addArrangedSubview(rightImageView)
        rightImageView.isHidden = rightImageView.image == nil
    }
    
}
