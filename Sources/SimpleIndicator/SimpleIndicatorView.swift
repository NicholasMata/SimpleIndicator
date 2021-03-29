//
//  SimpleIndicatorView.swift
//
//
//  Created by Nicholas Mata on 1/20/21.
//

import UIKit

open class SimpleIndicatorView: UIView {
    private static let colorAnimationKey = "simpleindicator.color"
        
    public var colors: [UIColor] {
        didSet {
            guard self.isAnimating else {
                return
            }
            self.applyColorAnimation()
        }
    }

    public var lineWidth: CGFloat {
        didSet {
            self.shapeLayer.lineWidth = self.lineWidth
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 30, height: 30)
    }
    
    private lazy var shapeLayer: ProgressShapeLayer = {
        ProgressShapeLayer(strokeColor: colors.first!, lineWidth: lineWidth)
    }()
    
    public var isAnimating: Bool = false {
        didSet {
            if self.isAnimating {
                self.animateStroke()
                self.animateRotation()
            } else {
                self.shapeLayer.removeFromSuperlayer()
                self.layer.removeAllAnimations()
            }
        }
    }
    
    public init(frame: CGRect,
                colors: [UIColor],
                lineWidth: CGFloat)
    {
        self.colors = colors
        self.lineWidth = lineWidth
        
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    public convenience init(colors: [UIColor], lineWidth: CGFloat) {
        self.init(frame: .zero, colors: colors, lineWidth: lineWidth)
    }
    
    public required init?(coder: NSCoder) {
        self.colors = [.black]
        self.lineWidth = 5
        
        super.init(coder: coder)
        
        self.backgroundColor = .clear
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.width / 2
        
        let path = UIBezierPath(ovalIn:
            CGRect(
                x: 0,
                y: 0,
                width: self.bounds.width,
                height: self.bounds.width
            )
        )
        
        self.shapeLayer.path = path.cgPath
    }
    
    private func animateStroke() {
        let startAnimation = StrokeAnimation(
            type: .start,
            beginTime: 0.25,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )
        
        let endAnimation = StrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]
        strokeAnimationGroup.isRemovedOnCompletion = false
        
        self.shapeLayer.add(strokeAnimationGroup, forKey: nil)
        
        self.applyColorAnimation()
        
        self.layer.addSublayer(self.shapeLayer)
    }
    
    private func animateRotation() {
        let rotationAnimation = RotationAnimation(
            direction: .z,
            fromValue: 0,
            toValue: CGFloat.pi * 2,
            duration: 2,
            repeatCount: .greatestFiniteMagnitude
        )
        rotationAnimation.isRemovedOnCompletion = false
        self.layer.add(rotationAnimation, forKey: nil)
    }
    
    private func applyColorAnimation() {
        let colorAnimation = StrokeColorAnimation(
            colors: colors.map { $0.cgColor },
            duration: Double(self.colors.count)
        )
        colorAnimation.isRemovedOnCompletion = false
        
        self.shapeLayer.removeAnimation(forKey: SimpleIndicatorView.colorAnimationKey)
        self.shapeLayer.add(colorAnimation, forKey: SimpleIndicatorView.colorAnimationKey)
    }
}
