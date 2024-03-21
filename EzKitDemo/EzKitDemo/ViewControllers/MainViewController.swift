//
//  MainViewController.swift
//  EzKitDemo
//
//  Created by Dusan Dudukovic on 12.3.24..
//
//  https://github.com/dusan-dudukovic/EzKit
//

import UIKit
import EzKit

class MainViewController: UIViewController {

    @IBOutlet weak var titleLabelContainer: EzView!
    
    @IBOutlet weak var ezView: EzView!
    @IBOutlet weak var buttonEzView: EzView!
    @IBOutlet weak var mainEzView: EzView!
    @IBOutlet weak var selectionEzView: EzView!
    @IBOutlet weak var highlightEzView: EzView!
    @IBOutlet weak var customEzView: EzView!
    
    @IBOutlet weak var consoleTestEzView: EzView!
    @IBOutlet weak var consoleIsHighlightedLabel: UILabel!
    @IBOutlet weak var consoleIsSelectedLabel: UILabel!
    
    @IBOutlet weak var consoleIsAnimatingSelectionLabel: UILabel!
    @IBOutlet weak var consoleIsAnimatingHighlightLabel: UILabel!
    @IBOutlet weak var consoleIsAnimatingCancelHighlightLabel: UILabel!
    
    @IBOutlet weak var componentExamplesEzView: EzView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - EzViewStyle
        // Configure EzView with predefined styles
        ezView.configure(style: .ez())
        
        buttonEzView.configure(style: .button(state: EzViewState(borderColor: .systemBlue,
                                                                 backgroundColor: .systemBlue,
                                                                 cornerRadius: 6)))
        
        mainEzView.configure(style: .main(selectedBorderColor: .systemIndigo,
                                          selectedBackgroundColor: .systemIndigo.withAlphaComponent(0.1),
                                          selectedCornerRadius: 12))
        
        selectionEzView.configure(style: .selectionOnly(selectedState: EzViewState(borderColor: .systemOrange,
                                                                                   backgroundColor: .systemOrange.withAlphaComponent(0.1),
                                                                                   cornerRadius: 8)))
        highlightEzView.configure(style: .highlightOnly(selectedState: EzViewState(borderColor: .systemYellow,
                                                                                   backgroundColor: .systemYellow.withAlphaComponent(0.1),
                                                                                   cornerRadius: 8)))
        
        customEzView.configure(style: .custom(selectedState: EzViewState(borderColor: .systemPink,
                                                                         backgroundColor: .systemPink.withAlphaComponent(0.1),
                                                                         borderWidth: 3,
                                                                         cornerRadius: 22),
                                              animationDuration: 0.1,
                                              highlightScale: 0.9,
                                              selectionScale: 1.08))
        
//        customEzView.configure(style: .none)
        
        // MARK: - EzViewConfiguration
        // Configure EzView with a configuration class
        let normalState = EzViewState(borderColor: .clear,
                                      backgroundColor: .systemGray,
                                      borderWidth: 0,
                                      cornerRadius: 8)
        let selectedState = EzViewState(borderColor: .systemMint,
                                        backgroundColor: .systemMint.withAlphaComponent(0.3),
                                        borderWidth: 3,
                                        cornerRadius: 8)
        
        let config = EzViewConfiguration(normalState: normalState,
                                         selectedState: selectedState,
                                         animationDuration: 0.3,
                                         highlightScale: 0.95,
                                         selectionScale: 1.05)
        
        consoleTestEzView.configure(configuration: config)
        setupCallbacks()
        
        // If you perfer using delegates:
        consoleTestEzView.delegate = self
        
        setupConsoleLabels()
        
        componentExamplesEzView.configure(style: .button(state: EzViewState(borderColor: .systemGreen,
                                                                            backgroundColor: .clear)))
    }

    private func setupCallbacks() {
        consoleTestEzView.onSelection = { [weak self] isSelected in
            let text = "\(isSelected)"
            self?.consoleIsSelectedLabel.text = text
        }
        consoleTestEzView.onHighlight = { [weak self] isHighlighted in
            let text = "\(isHighlighted)"
            self?.consoleIsHighlightedLabel.text = text
        }
        
        buttonEzView.onSelection = { _ in
            // dont need to check for selection here
            print(".button tap")
        }
        
        componentExamplesEzView.onSelection = { [weak self] _ in
            self?.performSegue(withIdentifier: "showComponents", sender: nil)
        }
    }

    private func setupConsoleLabels() {
        consoleIsSelectedLabel.text = "\(consoleTestEzView.isSelected)"
        consoleIsHighlightedLabel.text = "\(consoleTestEzView.isHighlighted)"
    }
    
}

extension MainViewController: EzViewDelegate {
    func didSelect(_ ezView: EzView, isSelected: Bool) {
        if ezView == consoleTestEzView {
            print("EzViewDelegate isSelected:", isSelected)
        }
    }
    
    func didHighlight(_ ezView: EzView, isHighlighted: Bool) {
        if ezView == consoleTestEzView {
            print("EzViewDelegate isHighlighted:", isHighlighted)
        }
    }
    
    func didChangeAnimationState(_ ezView: EzView, state: EzAnimationState) {
        if ezView == consoleTestEzView {
            consoleIsAnimatingSelectionLabel.text = "\(state.isAnimatingSelection)"
            consoleIsAnimatingHighlightLabel.text = "\(state.isAnimatingHighlight)"
            consoleIsAnimatingCancelHighlightLabel.text = "\(state.isAnimatingCancelHighlight)"
            
            // during selection, actions are disabled
            consoleIsHighlightedLabel.textColor = state.isAnimatingSelection ? .red : .label
            consoleIsSelectedLabel.textColor = state.isAnimatingSelection ? .red : .label
        }
    }
}
