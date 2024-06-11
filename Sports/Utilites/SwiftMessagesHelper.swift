//
//  SwiftMessagesHelper.swift
//  ChatApp
//
//  Created by ios Dev on 08/05/2024.
//

import UIKit
import SwiftMessages

enum Theme {
    case success
    case info
    case warning
    case error
}

enum PresentationStyle {
    case top
    case bottom
    case center
}

enum Duration: Equatable {
    case seconds(seconds: Double)
    case forever

    static func == (lhs: Duration, rhs: Duration) -> Bool {
        switch (lhs, rhs) {
        case (.forever, .forever):
            return true
        case let (.seconds(seconds: seconds1), .seconds(seconds: seconds2)):
            return seconds1 == seconds2
        default:
            return false
        }
    }
}


class SwiftMessagesHelper {

    static let shared = SwiftMessagesHelper()
    private let durationInSeconds: Double = 2.0 // Adjust as needed

    private init() {} // Singleton

    // MARK: - Public Methods

    @MainActor func showMessage(title: String, body: String, theme: Theme, presentationStyle: PresentationStyle, duration: Duration, buttonTitle: String? = nil, onTapButton: (() -> Void)? = nil) {
        let messageView = MessageView.viewFromNib(layout: .messageView)
        messageView.configureTheme(theme == .success ? .success : theme == .info ? .info : theme == .warning ? .warning : .error)
        messageView.configureContent(title: title, body: body)
        messageView.button?.isHidden = buttonTitle == nil
        if let buttonTitle = buttonTitle {
            messageView.button?.setTitle(buttonTitle, for: .normal)
            messageView.buttonTapHandler = { _ in
                onTapButton?()
                SwiftMessages.hide(animated: true)
            }
        }
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = presentationStyle == .top ? .top : presentationStyle == .bottom ? .bottom : .center
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar + 1)  // Ensures it appears over the navigation bar
        config.duration = duration == .forever ? .forever : .seconds(seconds: durationInSeconds)
        SwiftMessages.show(config: config, view: messageView)
    }

}
