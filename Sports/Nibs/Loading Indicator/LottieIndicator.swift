//
//  LottieIndicator.swift
//  Sports
//
//  Created by ios Dev on 14/06/2024.
//

import UIKit
import Lottie

extension UIView {

    private struct LottieLoaderKeys {
        static var loaderView = "loaderView"
    }

    private var loaderView: UIView? {
        get {
            return objc_getAssociatedObject(self, &LottieLoaderKeys.loaderView) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &LottieLoaderKeys.loaderView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func showLottieLoader(with name: String = "Loading") {
        guard loaderView == nil else { return }

        // Create and configure the Lottie animation view
        let animationView = LottieAnimationView(name: name)
        animationView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFill
        
        // Semi-transparent blue tint
        animationView.backgroundColor = UIColor.accent.withAlphaComponent(0.2)

        // Corner radius
        animationView.layer.cornerRadius = 20
        animationView.layer.masksToBounds = true

        // Center the animation view
        animationView.center = self.center

        // Content mode
        animationView.contentMode = .scaleAspectFill

        // Add shadow
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowOpacity = 0.3
        animationView.layer.shadowOffset = CGSize(width: 5, height: 5)
        animationView.layer.shadowRadius = 10

        // Add blur effect
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = animationView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Insert the blur effect view behind the animation
        animationView.insertSubview(blurEffectView, at: 0)
        
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()

        // Create a container view for the loader
        let containerView = UIView(frame: self.bounds)
        containerView.backgroundColor = UIColor.clear
        containerView.addSubview(animationView)
        
        // Add the container view to the current view
        self.addSubview(containerView)
        
        // Save the container view in the associated object
        self.loaderView = containerView
    }
    
    func showFailureLottieLoader(with name: String = "Failed") {
        guard loaderView == nil else { return }

        // Create and configure the Lottie animation view
        let animationView = LottieAnimationView(name: name)
        animationView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)

        // Semi-transparent blue tint
        animationView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)

        // Corner radius
        animationView.layer.cornerRadius = 20
        animationView.layer.masksToBounds = true

        // Center the animation view
        animationView.center = self.center

        // Content mode
        animationView.contentMode = .scaleAspectFill

        // Add shadow
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowOpacity = 0.3
        animationView.layer.shadowOffset = CGSize(width: 5, height: 5)
        animationView.layer.shadowRadius = 10

        // Add blur effect
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = animationView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Insert the blur effect view behind the animation
        animationView.insertSubview(blurEffectView, at: 0)
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()

        // Create a container view for the loader
        let containerView = UIView(frame: self.bounds)
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        containerView.addSubview(animationView)
        
        // Add the container view to the current view
        self.addSubview(containerView)
        
        // Save the container view in the associated object
        self.loaderView = containerView
        
//        hideLottieLoaderByTime()
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
