# EzKit

`EzKit` is a collection of custom UIKit components, based on `EzView` - selectable and highlightable UIView subclass. All interaction is animated and delegated, with high customization options. Need a button with 2 labels and 2 images? I got you! An out of the box, animated checkbox in UIKit? Ez.

https://github.com/dusan-dudukovic/EzKit/assets/88319632/a1f94626-cf75-4072-9a3a-38f1dbd07477

## Installation

### Swift Package Manager

In your Xcode project, go to 'File > 'Add Package Dependencies...' and then enter the package URL in the search field: `https://github.com/dusan-dudukovic/EzKit`. Choose 'Up to Next Major Version' and you're good to go!

If you are editing your `Package.swift` file directly, add a value into the `dependencies` array:

```swift
dependencies: [
    .package(url: "https://github.com/dusan-dudukovic/EzKit", .upToNextMajor(from: "0.5.0"))
]
```

### CocoaPods

Check out [CocoaPods](https://cocoapods.org/) for CocoaPods installation guide.

With CocoaPods installed, navigate to your project folder and run `pod init`. When you have your `Podfile` created, simply add the following line into it:

```swift
    pod 'EzKit-Pod'
```

You can also specify the version you want with the `~>` operator, if you do not want your pod to update to the latest version on accident, for example:


```swift
    pod 'EzKit-Pod', '~> 0.3.1'
```

Save the `Podfile` changes and run `pod install` command. After that, use the created `.xcworkspace` file to enter your project.

## EzView

Easy to use and powerful UIView subclass. It will react to user's long presses and allows highlighting and selection actions, while being animated.

https://github.com/dusan-dudukovic/EzKit/assets/88319632/2cb03ccd-8c15-4baa-9905-0aef5126f4d8

### Configuration

Configure `EzView` with one of two functions, using `EzViewStyle` or `EzViewConfiguration`. You can use either approach.

#### Option 1 (ez) - `EzViewStyle`

`EzViewStyle` configuration enum offers predefined behavior with less configuration options, but is easier to implement. 

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


https://github.com/dusan-dudukovic/EzKit/assets/88319632/d131f208-3317-4d48-abcd-db5178e893fe


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

https://github.com/dusan-dudukovic/EzKit/assets/88319632/f124c8ea-29c9-4f60-8ba9-a72117317da6

```swift
ezCheckbox.configure(style: .ez(tintColor: .systemGreen),
                     text: "I am a checkbox!",
                     normalTextColor: .systemGreen,
                     selectedTextColor: .systemGreen,
                     normalStateImage: UIImage(systemName: "circle")!,
                     selectedStateImage: UIImage(systemName: "checkmark.circle")!)
```

Use closures/delegate functions like before to catch the taps and highlights and you're ready to go!

All feedback is much appreciated. I hope you make good use of this little library. Enjoy!

## License

EzKit is released under the MIT license. [See LICENSE](https://github.com/dusan-dudukovic/EzKit/blob/master/LICENSE) for details.
