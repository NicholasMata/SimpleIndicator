//
//  ViewController.swift
//  Example
//
//  Created by Nicholas Mata on 3/29/21.
//

import SimpleIndicator
import UIKit

class ViewController: UIViewController {
    @IBOutlet var indicatorView: SimpleIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicatorView.isAnimating = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.indicatorView.colors = [.blue, .cyan, .magenta]
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.indicatorView.lineWidth = 10
            }
        }
    }
}
