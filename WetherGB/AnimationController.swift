//
//  AnimationController.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 14.05.2021.
//

import UIKit

class AnimationController: UIViewController {

	@IBOutlet weak var viewForAnimate: UIView!
	var propertyAnimator: UIViewPropertyAnimator!

	override func viewDidLoad() {
		super.viewDidLoad()
		let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
		viewForAnimate.addGestureRecognizer(panRecognizer)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

//		propertyAnimation()

	}

	@objc func onPan(_ recognizer: UIPanGestureRecognizer) {
		switch recognizer.state {

		case .began:
			propertyAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: {
				self.viewForAnimate.frame = self.viewForAnimate.frame.offsetBy(dx: 0, dy: 200)
			})

		case .changed:
			let transition = recognizer.translation(in: viewForAnimate)
			if transition.y > 0 {
				propertyAnimator.fractionComplete = transition.y/200
			} else {
				propertyAnimator.fractionComplete = transition.y/200
			}

		case .ended:
			let transition = recognizer.translation(in: viewForAnimate)
			propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
		default:
			return
		}
	}

	func propertyAnimation() {
//		let animation = UIViewPropertyAnimator(duration: 1, curve: UIView.AnimationCurve.easeInOut) {
//			self.viewForAnimate.frame = self.viewForAnimate.frame.offsetBy(dx: 0, dy: 200)
//		}

		let springAnimation = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
			self.viewForAnimate.frame = self.viewForAnimate.frame.offsetBy(dx: 0, dy: 200)
		}

		springAnimation.startAnimation()
	}

	func pathAnimation(){

		let cloudView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

		viewForAnimate.addSubview(cloudView)

		let path = UIBezierPath()
		path.move(to: CGPoint(x: 40, y: 20))
		path.addLine(to: CGPoint(x: 340, y: 20))
		path.addLine(to: CGPoint(x: 340, y: 320))
		path.lineWidth = 10
		path.close()


		let layerAnimation = CAShapeLayer()
		layerAnimation.path = path.cgPath
		layerAnimation.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		layerAnimation.fillColor = UIColor.clear.cgColor
		layerAnimation.lineWidth = 8
		layerAnimation.lineCap = .butt

		cloudView.layer.addSublayer(layerAnimation)

		let pathAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
		pathAnimationEnd.fromValue = 0
		pathAnimationEnd.toValue = 1
		pathAnimationEnd.duration = 2
		pathAnimationEnd.fillMode = .both
		pathAnimationEnd.isRemovedOnCompletion = false
		layerAnimation.add(pathAnimationEnd, forKey: nil)

		let pathAnimationStart = CABasicAnimation(keyPath: "strokeStart")
		pathAnimationStart.fromValue = 0
		pathAnimationStart.toValue = 1
		pathAnimationStart.duration = 2
		pathAnimationStart.fillMode = .both
		pathAnimationStart.isRemovedOnCompletion = false
		pathAnimationStart.beginTime = 1

		let animationGroup = CAAnimationGroup()
		animationGroup.duration = 3
		animationGroup.fillMode = CAMediaTimingFillMode.backwards
		animationGroup.animations = [pathAnimationEnd, pathAnimationStart]
		animationGroup.repeatCount = .infinity
		layerAnimation.add(animationGroup, forKey: nil)

	}

	func startCAAnimationGroup() {
		let animationGroup = CAAnimationGroup()
		animationGroup.duration = 1
		animationGroup.fillMode = .forwards
		animationGroup.isRemovedOnCompletion = false
		animationGroup.timingFunction = .init(name: CAMediaTimingFunctionName.easeInEaseOut)
//		animationGroup.timingFunction = .init(controlPoints: <#T##Float#>, <#T##c1y: Float##Float#>, <#T##c2x: Float##Float#>, <#T##c2y: Float##Float#>)
		let basicAnimationTransition = CABasicAnimation(keyPath: "position.y")
		basicAnimationTransition.toValue = 300

		let basicAnimationAlpha = CABasicAnimation(keyPath: "opacity")
		basicAnimationAlpha.toValue = 0

		animationGroup.animations = [basicAnimationTransition, basicAnimationAlpha]

		viewForAnimate.layer.add(animationGroup, forKey: nil)

	}

	func startAnimateKeyframes() {

//		UIView.animate(
//			withDuration: 1) {
//			self.viewForAnimate.center.x += 100
//		} completion: { _ in
//			UIView.animate(
//				withDuration: 1) {
//				self.viewForAnimate.center.y += 100
//			} completion: { _ in
//				UIView.animate(
//					withDuration: 1) {
//					self.viewForAnimate.center.x -= 100
//				}
//			}
//		}

		UIView.animateKeyframes(withDuration: 3,
								delay: 0,
								options: [],
								animations: {

									UIView.addKeyframe(
										withRelativeStartTime: 0,
										relativeDuration: 1/3) {
										self.viewForAnimate.center.x += 100
									}

									UIView.addKeyframe(
										withRelativeStartTime: 1/3,
										relativeDuration: 1/3) {
										self.viewForAnimate.center.y += 100
									}

									UIView.addKeyframe(
										withRelativeStartTime: 2/3,
										relativeDuration: 1/3) {
										self.viewForAnimate.center.x -= 100
									}
								},
								completion: nil)

	}
}
