//
//  CustomNavigationCintroller.swift
//  WetherGB
//
//  Created by Stanislav Belykh on 21.05.2021.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

	let interactiveTransition = CustomInteractiveTransition()

	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
	}

	func navigationController(
		_ navigationController: UINavigationController,
		interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

		return interactiveTransition.hasStarted ? interactiveTransition : nil
	}

	func navigationController(
		_ navigationController: UINavigationController,
		animationControllerFor operation: UINavigationController.Operation,
		from fromVC: UIViewController,
		to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
			if operation == .push {
				self.interactiveTransition.viewController = toVC
				return PushAnimator()
			} else if operation == .pop {
				if navigationController.viewControllers.first != toVC {
					self.interactiveTransition.viewController = toVC
				}
				return PopAnimator()
			}
			return nil
	}
}

extension CustomNavigationController: UIViewControllerTransitioningDelegate {

	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return PopAnimator()
	}

	func animationController(forPresented presented: UIViewController,
							 presenting: UIViewController,
							 source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return PushAnimator()
	}
}
