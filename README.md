# About BSLinewView
BSLineview is a simple Swift library for custom drawings using Core Graphics. BSLineview leverages the power of UIResponder response methods and drawRect to draw on screen illustrations. By utilizing quadratic Bézier curve, BSLineView draws lines which are smooth and consistent. BSLineView is a subclass of UIView, and can be used anywhere for limitless functionality.

# Requirements
BSLineView is written in Swift 1.2. It has been tested in IOS 7.0+ and Works with Xcode 6.4 and 7.0 Beta

# Using BSLineView in Your App
Simply create a BSLineView object, supply it with the frame-bounds, and add it as a subview.

# Code Example

     override func viewDidLoad() {
            super.viewDidLoad()
            let drawingView = BSLineView(frame: view.frame)
            view.addSubview(drawingView)
        }
        
