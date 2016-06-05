# SlideMenuDovi

[![CI Status](http://img.shields.io/travis/Douvi/SlideMenuDovi.svg?style=flat)](https://travis-ci.org/Douvi/SlideMenuDovi)
[![Version](https://img.shields.io/cocoapods/v/SlideMenuDovi.svg?style=flat)](http://cocoapods.org/pods/SlideMenuDovi)
[![License](https://img.shields.io/cocoapods/l/SlideMenuDovi.svg?style=flat)](http://cocoapods.org/pods/SlideMenuDovi)
[![Platform](https://img.shields.io/cocoapods/p/SlideMenuDovi.svg?style=flat)](http://cocoapods.org/pods/SlideMenuDovi)

## Why an other Slide Menu!!!

If you want to create a specific Animation, aside the current animations, this lib is made for you :).

## Who use **SlideMenuDovi**

First you need to look at **SliderMenuOptions**, that will give you a full list of options (with, opacity, shadow, status bar, etc)

```
public struct SliderMenuOptions {
    // you will define the left side
    public static var leftViewWidth: CGFloat = 242.0
    public static var leftBezelWidth: CGFloat = 16.0
    public static var leftPanFromBezel: Bool = true

    // you will define the right side
    public static var rightViewWidth: CGFloat = 242.0
    public static var rightBezelWidth: CGFloat = 16.0
    public static var rightPanFromBezel: Bool = true

    // the type of animation
    public static var animationType: SliderMenuAnimation = SliderMenuAnimationDefault()

    // The menu will not open or close under X pixel
    public static var pointOfNoReturnWidth: CGFloat = 44.0

    // opacity between the MainViewController and the Menu (Left or Right)
    public static var contentViewOpacity: CGFloat = 0.0

    // The sliding view will be set with a shadow
    public static var shadowOpacity: CGFloat = 1.0
    public static var shadowRadius: CGFloat = 12
    public static var shadowOffset: CGSize = CGSizeMake(0,0)
    public static var shadowColor: UIColor = UIColor.blackColor()

    public static var animationDuration: CGFloat = 0.4

    // status bar options
    public static var hideStatusBar: Bool = false
    public static var showsStatusBarBackground: Bool = false
    public static var statusBarBackgroundColor: UIColor = UIColor.clearColor()
}
```

Then you need to override **SliderMenuViewController** like that

```
class YourRootViewController: SliderMenuViewController {

  override func viewDidLoad() {
      super.viewDidLoad()

      let main = YourMainViewController()
      let left = YourLeftViewController()
      let right = YourRightViewController()

      self.initPanel(main, leftMenuViewController: left, rightMenuViewController: right)
  }
}

```

Done your project is setup with a SlideMenu!!!

## Animations available

1. Classic animation MainViewController will slide
```
  SliderMenuOption.animationType = SliderMenuAnimationDefault()
```

[logo]: anim_default.png

2. Android animation, left or right side will slider over center view
```
  SliderMenuOption.animationType = SliderMenuAnimationSliderOver()
```

## Custom Animation

You are not happy with those animations, do not worry daddy is here to help you :).
To create your own Animation you just need to implement **SliderMenuAnimation** which implements 5 protocols (**AnimatorChecker**, **AnimatorFire**, **AnimatorGesture**, **AnimatorVector**, **GlobalVariables**).

**AnimatorChecker**

```
  /**
   *  Check if menu is open or close
   */
  public protocol AnimatorChecker: GlobalVariables {
      func isLeftSideOpen() -> Bool
      func isLeftSideHidden() -> Bool
      func isRightSideOpen() -> Bool
      func isRightSideHidden() -> Bool
  }
```

**AnimatorFire**

```
  /**
   *  It will fire the animation
   */
  public protocol AnimatorFire: GlobalVariables {
      func toggleLeft()
      func toggleRight()

      func closeLeft()
      func closeRight()

      func openLeft()
      func openRight()

      func addShadowToView(targetContainerView: UIView)
      func removeShadow(targetContainerView: UIView)

      func animateLeftSideToOpen()
      func animateLeftSideToClose()
      func animateRightSideToOpen()
      func animateRightSideToClose()
  }
```

**AnimatorGesture**

```
/**
 *  It will be call when the Pan gesture (left or right) is activated
 */
public protocol AnimatorGesture: GlobalVariables {
    func beganLeftTranslationGesture()
    func changedLeftTranslationGesture(frameTranslation: CGRect)
    func endLeftTranslationGesture(velocity: CGPoint) -> PanInfo

    func beganRightTranslationGesture()
    func changedRightTranslationGesture(frameTranslation: CGRect)
    func endRightTranslationGesture(velocity: CGPoint) -> PanInfo

    func applyLeftGestureTranslation(translation: CGPoint, toFrame:CGRect) -> CGRect
    func applyRightGestureTranslation(translation: CGPoint, toFrame:CGRect) -> CGRect
}
```

**AnimatorVector**

```
/**
 *  It will be call to close or open menu
 */
public protocol AnimatorVector: GlobalVariables {
    func resetAnimationLeftSide()
    func resetAnimationRightSide()
    func transitionToSize(transitionCoordinator: UIViewControllerTransitionCoordinator)

    func openLeftWithVelocity(velocity: CGFloat)
    func closeLeftWithVelocity(velocity: CGFloat)

    func openRightWithVelocity(velocity: CGFloat)
    func closeRightWithVelocity(velocity: CGFloat)
}
```

All those Protocols are implementing **GlobalVariables** which will help you to get access to all information you need.

```
/**
 *  Give you access to all you need
 */
public protocol GlobalVariables: class {
    var rootView: UIView { get }
    var menuTools: MenuTools { get }
    var menuViews: MenuViews { get }
    var menuViewControllers: MenuViewControllers { get }
    var animationType: SliderMenuAnimation { get }
    var gesture: SliderMenuGesture { get }
    var leftViewController: UIViewController? { get }
    var rightViewController: UIViewController? { get }
    var mainViewController: UIViewController? { get }
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SlideMenuDovi is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SlideMenuDovi"
```

## Author

Edouard Roussillon

## License

SlideMenuDovi is available under the MIT license. See the LICENSE file for more info.
