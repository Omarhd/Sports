//
//  LottieIndicator.swift
//  Sports
//
//  Created by ios Dev on 14/06/2024.
//

import UIKit
import Lottie

extension UIView {

    private static var loaderViewKey: UInt8 = 0

    private var loaderView: UIView? {
        get {
            return objc_getAssociatedObject(self, &UIView.loaderViewKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &UIView.loaderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func showLottieLoader(with name: String = "Loading") {
        guard loaderView == nil else { return }

        let animationView = LottieAnimationView(name: name)
        animationView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFill
        animationView.backgroundColor = UIColor.accent.withAlphaComponent(0.2)
        animationView.layer.cornerRadius = 20
        animationView.layer.masksToBounds = true
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFill
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowOpacity = 0.3
        animationView.layer.shadowOffset = CGSize(width: 5, height: 5)
        animationView.layer.shadowRadius = 10

        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = animationView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        animationView.insertSubview(blurEffectView, at: 0)
        
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()

        let containerView = UIView(frame: self.bounds)
        containerView.backgroundColor = UIColor.clear
        containerView.addSubview(animationView)
        
        self.addSubview(containerView)
        
        self.loaderView = containerView
    }
    
    func showFailureLottieLoader(with name: String = "Failed") {
        guard loaderView == nil else { return }

        let animationView = LottieAnimationView(name: name)
        animationView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        animationView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        animationView.layer.cornerRadius = 20
        animationView.layer.masksToBounds = true
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFill
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowOpacity = 0.3
        animationView.layer.shadowOffset = CGSize(width: 5, height: 5)
        animationView.layer.shadowRadius = 10

        // Add blur effect
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = animationView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        animationView.insertSubview(blurEffectView, at: 0)
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()

        let containerView = UIView(frame: self.bounds)
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        containerView.addSubview(animationView)
        
        self.addSubview(containerView)
        
        self.loaderView = containerView
    }
    
    func showLikeLottieLoader(with name: String = "Like") {
        guard loaderView == nil else { return }

        let animationView = LottieAnimationView(name: name)
        animationView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.5

        let containerView = UIView(frame: self.bounds)
        containerView.addSubview(animationView)
        
        self.addSubview(containerView)
        self.loaderView = containerView
        
        animationView.play { (finished) in
            if finished {
                containerView.removeFromSuperview()
                self.loaderView = nil
            }
        }
    }


    func hideLottieLoader() {
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
    
    func hideLottieLoaderByTime(after delay: TimeInterval = 10.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.loaderView?.removeFromSuperview()
            self?.loaderView = nil
        }
    }
}
