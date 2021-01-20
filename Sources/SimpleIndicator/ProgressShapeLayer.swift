//
//  ProgressShapeLayer.swift
//
//
//  Created by Nicholas Mata on 1/20/21.
//

import UIKit

class ProgressShapeLayer: CAShapeLayer {
    public init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()

        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }
}
