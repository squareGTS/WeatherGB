//
//  StarView.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 14.05.2021.
//

import UIKit

class StarView: UIView {

	func startAnimation() {

	}

	override func draw(_ rect: CGRect) {
		super.draw(rect)
		guard let context = UIGraphicsGetCurrentContext() else { return }
		context.setStrokeColor(UIColor.black.cgColor)
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 40, y: 20))
		path.addLine(to: CGPoint(x: 340, y: 20))
		path.addLine(to: CGPoint(x: 340, y: 320))
		path.lineWidth = 10
		path.close()
		path.stroke()

		let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
		pathAnimation.fillMode = .both
		pathAnimation.duration = 2
		pathAnimation.fromValue = 0
		pathAnimation.toValue = 1

		layer.add(pathAnimation, forKey: nil)
	}

}
