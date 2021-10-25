//
//  LoginFormViewController.swift
//  WetherGB
//
//  Created by Станислав Белых on 20.04.2021.
//

import UIKit

class LoginFormViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
	@IBOutlet weak var loginTitleView: UILabel!
	@IBOutlet weak var passwordTitleView: UILabel!
	@IBOutlet weak var titleView: UILabel!

	var propertyAnimatorUp: UIViewPropertyAnimator!
	var propertyAnimatorDown: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        nextButton.layer.cornerRadius = 5
        nextButton.backgroundColor = .orange
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
		self.view.addGestureRecognizer(recognizer)
		startAnimation()
		startTextFieldAnimation()
		startTitleAnimation()

	}
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

	func startAnimation() {
		let offset = abs(self.loginTitleView.frame.midY - self.passwordTitleView.frame.midY)

		self.loginTitleView.transform = CGAffineTransform(translationX: 0, y: offset)
		self.passwordTitleView.transform = CGAffineTransform(translationX: 0, y: -offset)

		UIView.animateKeyframes(withDuration: 1,
								delay: 1,
								options: .calculationModeCubicPaced,
								animations: {
									UIView.addKeyframe(withRelativeStartTime: 0,
													   relativeDuration: 0.5,
													   animations: {
														self.loginTitleView.transform = CGAffineTransform(translationX: 150, y: 50)
														self.passwordTitleView.transform = CGAffineTransform(translationX: -150, y: -50)
													   })
									UIView.addKeyframe(withRelativeStartTime: 0.5,
													   relativeDuration: 0.5,
													   animations: {
														self.loginTitleView.transform = .identity
														self.passwordTitleView.transform = .identity
									})
		}, completion: nil)
	}

	func startTextFieldAnimation() {

		let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
		fadeInAnimation.fromValue = 0
		fadeInAnimation.toValue = 1

		let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
		scaleAnimation.fromValue = 0
		scaleAnimation.toValue = 1
		scaleAnimation.stiffness = 150
		scaleAnimation.mass = 2

		let animationsGroup = CAAnimationGroup()
		animationsGroup.duration = 1
		animationsGroup.beginTime = CACurrentMediaTime() + 1
		animationsGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
		animationsGroup.fillMode = CAMediaTimingFillMode.backwards
		animationsGroup.animations = [fadeInAnimation, scaleAnimation]

		self.loginTextField.layer.add(animationsGroup, forKey: nil)
		self.passwordTextField.layer.add(animationsGroup, forKey: nil)
	}

	func startTitleAnimation() {
		self.titleView.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height / 2)

		let animator = UIViewPropertyAnimator(duration: 1,
											  dampingRatio: 0.5,
											  animations: {
												  self.titleView.transform = .identity
		})

		animator.startAnimation(afterDelay: 1)
	}

	@objc func onPan(_ recognizer: UIPanGestureRecognizer) {
		switch recognizer.state {

		case .began:
			propertyAnimatorDown = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: {
				self.nextButton.frame = self.nextButton.frame.offsetBy(dx: 0, dy: 200)
			})

			propertyAnimatorUp = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: {
				self.nextButton.frame = self.nextButton.frame.offsetBy(dx: 0, dy: -200)
			})

			propertyAnimatorDown.addCompletion { _ in
				self.nextButton.frame = self.nextButton.frame.offsetBy(dx: 0, dy: -200)
			}
			propertyAnimatorUp.addCompletion { (_) in
				self.nextButton.frame = self.nextButton.frame.offsetBy(dx: 0, dy: 200)
			}

		case .changed:
			let transition = recognizer.translation(in: nextButton)
			if transition.y > 0 {
				propertyAnimatorDown.fractionComplete = transition.y/200
			} else {
				propertyAnimatorUp.fractionComplete = transition.y/200
			}

		case .ended:
//			let transition = recognizer.translation(in: nextButton)
			propertyAnimatorUp.continueAnimation(withTimingParameters: nil, durationFactor: 0)
			propertyAnimatorDown.continueAnimation(withTimingParameters: nil, durationFactor: 0)
		default:
			return
		}
	}
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "LoginSegue" else {
            return false
        }
        let isLoginPasswordCorrect = loginTextField.text == "" && passwordTextField.text == ""
        
        if isLoginPasswordCorrect {
            return true
        } else {
            showErrorAlert()
        }
        
        return false
    }
    
    private func showErrorAlert() {
        // Создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.passwordTextField.text = ""
            self?.loginTextField.text = ""
        }
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard() {
        scrollView?.endEditing(true)
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }

    
    @IBAction func login(_ sender: Any) {
        print("Button pressed")
        
        if loginTextField.text == "admin" && passwordTextField.text == "123" {
            print("login success")
        } else {
            print("login error")
        }
    }
}
