# iOSCustomTransitions

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

iOSCustomTransitions is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'iOSCustomTransitions'
```
## Usage

Import iOSCustomTransitions

````swift
import iOSCustomTransitions
````

To use custom transitions your ViewController needs to conforms to UIViewControllerTransitioningDelegate as the following example.

```swift
extension MyViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZoomingPresentAnimator(originFrame: self.cardButton.frame, transitionStyle: .mixed, originViewSnapshot: self.cardButton.snapshotView(afterScreenUpdates: true))
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZoomingDismissAnimator(destinationFrame: self.cardButton.frame, transitionStyle: .mixed, destinationViewSnapshot: self.cardButton.snapshotView(afterScreenUpdates: false))
    }
}
```

Also you need to set the transitioningDelegate of destination ViewController to your origin ViewController

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segue.destination.transitioningDelegate = self
}
```

The following Transitions is available until now:

* ZoomingPresentAnimator
* ZoomingDismissAnimator
* BubblePresentAnimatorController
* BubbleDismissAnimatorController

## Author

charleslima, jlima.charles@gmail.com

## License

iOSCustomTransitions is available under the MIT license. See the LICENSE file for more info.

