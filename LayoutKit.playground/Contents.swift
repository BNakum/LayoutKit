// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit
import XCPlayground
import LayoutKit
import LayoutKitExampleLayouts

// REMINDER: you need to manually build LayoutKitExampleLayouts on the simulator for changes to be reflected in this playground.

var captured: UIView? = nil
let before = InsetLayout(
    inset: 10,
    tag: 1,
    sublayout: StackLayout(
        axis: .vertical,
        distribution: .fillEqualSpacing,
        tag: 2,
        sublayouts: [
            SizeLayout<UIView>(
                width: 100,
                height: 100,
                alignment: .topLeading,
                tag: 3,
                sublayout: SizeLayout<UIView>(
                    width: 10,
                    height: 10,
                    alignment: .bottomTrailing,
                    tag: 5,
                    config: { view in
                        view.backgroundColor = UIColor.redColor()
                        captured = view
                    }
                ),
                config: { view in
                    view.backgroundColor = UIColor.grayColor()
                }
            ),
            InsetLayout(
                inset: 0,
                tag: 6,
                sublayout:SizeLayout<UIView>(
                    width: 80,
                    height: 80,
                    alignment: .bottomTrailing,
                    tag: 7,
                    config: { view in
                        view.backgroundColor = UIColor.lightGrayColor()
                    }
                ),
                config: { view in
                    view.backgroundColor = UIColor.clearColor()
                }
            )
        ]
    ),
    config: { view in
        view.backgroundColor = UIColor.blackColor()
    }
)

let rootView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))

before.arrangement(width: 250, height: 250).makeViews(inView: rootView)

XCPlaygroundPage.currentPage.liveView = rootView

rootView

let after = InsetLayout(
    inset: 10,
    tag: 1,
    sublayout: StackLayout(
        axis: .vertical,
        distribution: .fillEqualSpacing,
        tag: 2,
        sublayouts: [
            SizeLayout<UIView>(
                width: 100,
                height: 100,
                alignment: .topLeading,
                tag: 3,
                config: { view in
                    view.backgroundColor = UIColor.grayColor()
                }
            ),
            InsetLayout(
                inset: 0,
                tag: 6,
                sublayout:SizeLayout<UIView>(
                    width: 50,
                    height: 50,
                    alignment: .bottomTrailing,
                    tag: 7,
                    sublayout: SizeLayout<UIView>(
                        width: 20,
                        height: 20,
                        alignment: .topLeading,
                        tag: 5,
                        config: { view in
                            view.backgroundColor = UIColor.redColor()
                            captured = view
                        }
                    ),
                    config: { view in
                        view.backgroundColor = UIColor.lightGrayColor()
                    }
                ),
                config: { view in
                    view.backgroundColor = UIColor.brownColor()
                }
            )
        ]
    ),
    config: { view in
        view.backgroundColor = UIColor.blackColor()
    }
)

captured?.frame

let afterArrangement = after.arrangement(width: 250, height: 250)
let animation = afterArrangement.prepareAnimation(for: rootView, direction: .RightToLeft)

captured?.frame

UIView.animateWithDuration(6.0, delay: 2, options: [], animations: {
    animation.apply()
    captured?.frame
}) { (b) in

    XCPlaygroundPage.currentPage.finishExecution()
}

rootView

//let l1 = LabelLayout(text: "Nick", alignment: .center, tag: 1)
//let l2 = LabelLayout(text: "Snyder", alignment: .center, tag: 1)
//
//let rv = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//rv.backgroundColor = UIColor.whiteColor()
//l1.arrangement(width: 100, height: 100).makeViews(inView: rv)
//
//XCPlaygroundPage.currentPage.liveView = rv
//rv
//
//let a = l2.arrangement(width: 100, height: 100).prepareAnimation(for: rv)
//UIView.animateWithDuration(6.0, delay: 2, options: [], animations: {
//    a.apply()
//}) { (b) in
//    XCPlaygroundPage.currentPage.finishExecution()
//}

//extension UIView {
//    static func commonAncestor(left: UIView?, right: UIView?) -> UIView? {
//        var leftDepth = depth(left)
//        var rightDepth = depth(right)
//        var leftView = left
//        var rightView = right
//
//        while leftDepth != rightDepth {
//            if leftDepth > rightDepth {
//                leftView = leftView?.superview
//                leftDepth -= 1
//            } else if rightDepth > leftDepth {
//                rightView = rightView?.superview
//                rightDepth -= 1
//            }
//        }
//
//        while leftView != rightView {
//            if leftView == nil || rightView == nil {
//                return nil
//            }
//            leftView = leftView?.superview
//            rightView = rightView?.superview
//        }
//
//        return left
//    }
//
//    static func depth(view: UIView?) -> Int {
//        guard let superview = view?.superview else {
//            return 0
//        }
//        return 1 + depth(superview)
//    }
//
//}
//
