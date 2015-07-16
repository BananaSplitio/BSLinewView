//
//  ViewController.swift
//  DemoProject
//
//  Created by Andrew on 2015-07-15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let drawingView = BSLineView(frame: view.frame)
        view.addSubview(drawingView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

