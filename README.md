# EzKit

`EzKit` is a collection of custom UIKit components, based on `EzView` - selectable and highlightable UIView subclass. All interaction is animated and delegated, with high customization options. Need a button with 2 labels and 2 images? I got you! An out of the box, animated checkbox in UIKit? Ez.

## EzView

Easy to use and powerful UIView subclass. It will react to user's long presses and allows highlighting and selection actions, while being animated.

### Configuration

Configure `EzView` with one of two functions, using `EzViewStyle` or `EzViewConfiguration`. You can use either approach.

#### Option 1 (ez) - `EzViewStyle`

`EzViewStyle` configuration enum offers predefined behavior with smaller available configuration options, but is easier to implement. 

```swift
ezView.configure(style: .ez(tintColor: .systemBlue))
```
Check out all of the possible cases to fit your desired behaviour. For example, `.selectionOnly` configuration style disables highlight animation and leaves only the selection one.

#### Option 2 (advanced) - `EzViewConfiguration`

`EzViewConfiguration` configuration class offers all of the possible configuration properties, so that you can tailor `EzView` to your specific needs. You do not need to provide all of the initialization properties - they will take the default values, which are defined in `EzConstants.swift` file.

```swift
// state of EzView while not selected
let normalState = EzViewState(borderColor: .clear,
                              backgroundColor: .systemGray)
                                      
// state of EzView while selected
let selectedState = EzViewState(borderColor: .systemMint,
                                backgroundColor: .systemMint.withAlphaComponent(0.3),
                                cornerRadius: 8)
        
ezView.configure(configuration: EzViewConfiguration(normalState: normalState,
                                                    selectedState: selectedState,
                                                    animationDuration: 0.3,
                                                    highlightScale: 0.95,
                                                    selectionScale: 1.05))
```
You will notice that most of the properties in all configuration initializers and functions have default values. This is to simplify the configuration process and make things work out of the box, possibly with as little as few lines of code. I still encourage you to dive in deeper into all of the options and play around with it.

### Callbacks and delegation

`EzView` has closures and delegate functions you can use for inversion of control - detection of selection, highlighting and animation state changes.

```swift
ezView.onSelection = { [weak self] isSelected in
    print("EzView has been selected?", isSelected)
}

ezView.onHighlight = { [weak self] isHighlighted in
    print("EzView has been highlighted?", isHighlighted)
}

ezView.onAnimationStateChange = { [weak self] state in
    print("EzView animation state:", state)
}
```

If you prefer to use delegates, `EzView` has got that too! Make your desired class a delegate (for example `UIViewController` or a view model) and implement the `EzViewDelegate` functions.

```swift
class MainViewController: UIViewController, EzViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        ezView.delegate = self
    }

    func didSelect(_ ezView: EzView, isSelected: Bool) {
        print("EzViewDelegate isSelected:", isSelected)
    }
    
    func didHighlight(_ ezView: EzView, isHighlighted: Bool) {
        print("EzViewDelegate isHighlighted:", isHighlighted)
    }
    
    func didChangeAnimationState(_ ezView: EzView, state: EzAnimationState) {
        print("EzView is animating selection?", state.isAnimatingSelection)
        print("EzView is animating highlighting?", state.isAnimatingHighlight)
        print("EzView is animating cancel highlight?", state.isAnimatingCancelHighlight)
    }
}
```

## Components

## EzButton

On the first look, `EzButton` will behave as a regular `UIButton`, but is so much more! This is where `EzView` shows its true powers. `EzButton` is a `EzView` subclass with 2 labels and 2 images added as subviews, organized in the familiar `UIButton` fashion. However, because of the `EzView`'s implementation, this button is fully animated and with options to customize everything!

Just like with `EzView`, you have multiple ways to configure `EzButton`. Almost all of the properties will have default values, if you just want things to work out of the box.
```swift
ezButton.configure(button: .ez(),
                   titleText: "I am a button",
                   textColor: .white)
```

If you want to customize labels and images separately, use their setup functions respectively.

```swift
ezButton.setupSubtitleLabel(text: "(with a subtitle)", textColor: .white)
ezButton.setupRightImageView(image: UIImage(systemName: "sun.max.fill"))
ezButton.setupLeftImageView(image: UIImage(systemName: "heart.fill"),
                            tintColor: .systemRed)
```

Since `EzButton` is a subclass of `EzView`, you can also configure it with previously shown configurations, if you want more options than provided here with `EzButtonStyle`. Again, play around with it!

Use closures/delegate functions like before to catch the taps and highlights and you're ready to go!

## EzCheckbox

`EzCheckbox` is another example of how you can utilize selection states of `EzView`. Simply define the images you want to be applied to each state, provide a `EzViewStyle` and tap away!

```swift
ezCheckbox.configure(style: .ez(tintColor: .systemGreen),
                     text: "I am a checkbox!",
                     textColor: .systemGreen,
                     normalStateImage: UIImage(systemName: "circle")!,
                     selectedStateImage: UIImage(systemName: "checkmark.circle")!)
```

Use closures/delegate functions like before to catch the taps and highlights and you're ready to go!

All feedback is much appreciated. I hope you make good use of this little library. Enjoy!

## License

EzKit is released under the MIT license. [See LICENSE](https://github.com/dusan-dudukovic/EzKit/blob/master/LICENSE) for details.
