//
//  PushAnimator.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 21.05.2021.
//

import UIKit

final class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

	private let duration: TimeInterval = 0.6

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return duration
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

		let source = transitionContext.viewController(forKey: .from)!
		let destination = transitionContext.viewController(forKey: .to)!

		transitionContext.containerView.addSubview(destination.view)
		destination.view.frame = source.view.frame
		destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)

		UIView.animateKeyframes(
			withDuration: duration,
			delay: 0,
			options: .calculationModePaced,
			animations: {
				UIView.addKeyframe(
					withRelativeStartTime: 0,
					relativeDuration: 0.75,
					animations: {
						let translation = CGAffineTransform(translationX: -200, y: 0)
						let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
						source.view.transform = translation.concatenating(scale)
					})
				UIView.addKeyframe(
					withRelativeStartTime: 0.2,
					relativeDuration: 0.4,
					animations: {
						let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
						let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
						destination.view.transform = translation.concatenating(scale)
					})
				UIView.addKeyframe(
					withRelativeStartTime: 0.6,
					relativeDuration: 0.4,
					animations: {
						destination.view.transform = .identity
					})
			}) { finished in
			if finished && !transitionContext.transitionWasCancelled {
				source.view.transform = .identity
			}
			transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
		}
	}
}
