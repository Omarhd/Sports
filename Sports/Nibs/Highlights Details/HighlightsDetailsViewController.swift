//
//  HighlightsDetailsViewController.swift
//  Sports
//
//  Created by ios Dev on 01/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HighlightsDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var highlightImage: UIImageView!
    @IBOutlet weak var highlightTitleLabel: UILabel!

    // MARK: Properties
    var presenter: HighlightsDetailsPresenterProtocol?
    let messageHelper: SwiftMessagesHelper
    
    // MARK: - Initialiser
    init(messageHelper: SwiftMessagesHelper = .shared) {
        self.messageHelper = messageHelper
        super.init(nibName: nil, bundle: nil)
    }
            
    required init?(coder: NSCoder) {
        self.messageHelper = SwiftMessagesHelper.shared
        super.init(coder: coder)
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        highlightImage.isUserInteractionEnabled = true
        highlightImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let image = highlightImage.image else { return }
        presenter?.didSelectTappedImage(image: image)
    }
}

extension HighlightsDetailsViewController: HighlightsDetailsControllerProtocol {
    
    func configureHighlightsUI(with highlight: HighlightsNews) {
        title = "News Details".localized
        highlightTitleLabel.text = highlight.headline?.htmlToString
        loadImages(loadImage: highlightImage, from: highlight.thumbnail)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .seconds(seconds: 3.0))
        setEmptyCase(imageName: "", title: "No Data".localized, message: "Try again Later".localized, containerView: self.view)
    }
    
}

