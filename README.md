# SlideMenuDovi

[![CI Status](http://img.shields.io/travis/Douvi/SlideMenuDovi.svg?style=flat)](https://travis-ci.org/Douvi/SlideMenuDovi)
[![Version](https://img.shields.io/cocoapods/v/SlideMenuDovi.svg?style=flat)](http://cocoapods.org/pods/SlideMenuDovi)
[![License](https://img.shields.io/cocoapods/l/SlideMenuDovi.svg?style=flat)](http://cocoapods.org/pods/SlideMenuDovi)
[![Platform](https://img.shields.io/cocoapods/p/SlideMenuDovi.svg?style=flat)](http://cocoapods.org/pods/SlideMenuDovi)
[![codecov](https://img.shields.io/codecov/c/github/Douvi/SlideMenuDovi.svg?maxAge=2592000)](https://codecov.io/gh/Douvi/SlideMenuDovi)

## Why an other Slide Menu!!!

If you want to create a specific Animation, aside the current animations, **SlideMenuDovi** is made for you :).

## How use **SlideMenuDovi**

First you need to look at **SliderMenuOptions**, this structure will give you a full list of options (width, opacity, shadow, status bar, etc)

```
public struct SliderMenuOptions {
    // Define the left side
    public static var leftViewWidth: CGFloat = 242.0
    public static var leftBezelWidth: CGFloat = 16.0
    public static var leftPanFromBezel: Bool = true

    // Define the right side
    public static var rightViewWidth: CGFloat = 242.0
    public static var rightBezelWidth: CGFloat = 16.0
    public static var rightPanFromBezel: Bool = true

    // Type of animation
    public static var animationType: SliderMenuAnimation = SliderMenuAnimationDefault()

    // Menu will open or close only after passing this value
    public static var pointOfNoReturnWidth: CGFloat = 44.0

    // Opacity of the view between the MainViewController and the Menu (Left or Right)
    public static var contentViewOpacity: CGFloat = 0.0

    // Sliding view will be set with a shadow
    public static var shadowOpacity: CGFloat = 1.0
    public static var shadowRadius: CGFloat = 12
    public static var shadowOffset: CGSize = CGSizeMake(0,0)
    public static var shadowColor: UIColor = UIColor.blackColor()

    // Animation duration
    public static var animationDuration: CGFloat = 0.4

    // Status bar options
    public static var hideStatusBar: Bool = false
    public static var showsStatusBarBackground: Bool = false
    public static var statusBarBackgroundColor: UIColor = UIColor.clearColor()
}
```

Then you need to override **SliderMenuViewController** like this:

```
import SlideMenuDovi

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

1. Classic animation, main view will slide
```
SliderMenuOptions.animationType = SliderMenuAnimationDefault()
```

![alt text]( https://github.com/Douvi/SlideMenuDovi/blob/develop/anim_default.gif "default")

2. Android animation, left or right side will slider over center view
```
SliderMenuOptions.animationType = SliderMenuAnimationSliderOver()
```

![alt text]( https://github.com/Douvi/SlideMenuDovi/blob/develop/anim_slide_over.gif "slide over")

## Custom Animation

You are not happy with the 2 default animations, do not worry daddy is here to help you :).
To create your own Animation you just need to implement **SliderMenuAnimation** which implements 5 protocols (**AnimatorChecker**, **AnimatorFire**, **AnimatorGesture**, **AnimatorVector**, **GlobalVariables**).

**SliderMenuAnimationX**

```
public class SliderMenuAnimationX: NSObject, SliderMenuAnimation {
    public var silderMenuGesture: SliderMenuGesture {
        get {
            return SliderMenuGestureDefault.sharedInstance
        }
    }

    /**
     *  Change the order of those views
     */
    public func orderList() {
        rootView.addSubview(self.menuViews.mainContainerView)
        rootView.addSubview(self.menuViews.opacityView)
        rootView.addSubview(self.menuViews.rightContainerView)
        rootView.addSubview(self.menuViews.leftContainerView)

        if SliderMenuOptions.showsStatusBarBackground {
            rootView.addSubview(self.menuViews.statusBarView)
        }

    }
}
```

If you want to override any protocol there is 2 ways:

### 1 - I do not have time

create a new file into 'AnimationType/SliderMenuAnimationX.swift'. Extend one of the **SliderMenuAnination** (can be **SliderMenuAnimationDefault** or **SliderMenuAnimationSliderOver**) and override all the methods you need.

```
public class SliderMenuAnimationX: NSObject, SliderMenuAnimation {
    public var silderMenuGesture: SliderMenuGesture {
        get {
            return SliderMenuGestureDefault.sharedInstance
        }
    }

    /**
     *  Change the order of those views
     */
    public func orderList() {
        self.rootView.addSubview(self.menuViews.mainContainerView)
        self.rootView.addSubview(self.menuViews.opacityView)
        self.rootView.addSubview(self.menuViews.rightContainerView)
        self.rootView.addSubview(self.menuViews.leftContainerView)

        if SliderMenuOptions.showsStatusBarBackground {
            self.rootView.addSubview(self.menuViews.statusBarView)
        }

    }

    public func isLeftSideOpen() -> Bool {
      // set the right result by using **GlobalVariables**'s methods (**SliderMenuAnimation** all ready implement **GlobalVariables**)
    }
}
```

### 2 - I do have time

create a new file into 'AnimatorChecker/AnimatorCheckerX.swift' which will implement **AnimatorChecker** or **AnimatorCheckerSliderOver**. You can do the same with all others protocols (**AnimatorFire**, **AnimatorGesture**, **AnimatorVector**, **GlobalVariables**)

```
public protocol AnimatorCheckerX: AnimatorChecker {}

extension AnimatorCheckerX {

  public func isLeftSideOpen() -> Bool {
    // set the right result by using **GlobalVariables**'s methods (**AnimatorChecker** all ready implement **GlobalVariables**)
  }

}
```

create a new file into 'AnimationType/SliderMenuAnimationX.swift'. Extend one of the **SliderMenuAnination** (can be **SliderMenuAnimationDefault** or **SliderMenuAnimationSliderOver**) and extend too the new protocol you just create **AnimatorCheckerX**

```
public class SliderMenuAnimationX: NSObject, SliderMenuAnimation, AnimatorCheckerX {
    public var silderMenuGesture: SliderMenuGesture {
        get {
            return SliderMenuGestureDefault.sharedInstance
        }
    }

    /**
     *  Change the order of those views
     */
    public func orderList() {
        self.rootView.addSubview(self.menuViews.mainContainerView)
        self.rootView.addSubview(self.menuViews.opacityView)
        self.rootView.addSubview(self.menuViews.rightContainerView)
        self.rootView.addSubview(self.menuViews.leftContainerView)

        if SliderMenuOptions.showsStatusBarBackground {
            self.rootView.addSubview(self.menuViews.statusBarView)
        }
    }
}
```

Done you just create your own Animation :)

### More Details

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

All those Protocols implement **GlobalVariables** which will help you to get access to all information you need.

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

SlideMenuDovi is using swift 2.2

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
