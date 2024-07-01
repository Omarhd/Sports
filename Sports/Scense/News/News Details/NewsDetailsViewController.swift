//
//  NewsDetailsViewController.swift
//  Sports
//
//  Created by ios Dev on 06/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Kingfisher

class NewsDetailsViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsContentTextView: UITextView!
    
    // MARK: Properties
    var presenter: NewsDetailsPresenterProtocol?
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
        newsImage.isUserInteractionEnabled = true
        newsImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let image = newsImage.image else { return }
        presenter?.didSelectTappedImage(image: image)
    }
}

extension NewsDetailsViewController: NewsDetailsControllerProtocol {
    
    func configureNewsUI(with news: News) {
        title = "News Details".localized
        newsTitleLabel.text = news.title?.htmlToString
        newsContentTextView.text = news.content?.htmlToString
        loadImages(loadImage: newsImage, from: news.path)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .seconds(seconds: 3.0))
        setEmptyCase(imageName: "", title: "No Data".localized, message: "Try again Later".localized, containerView: self.view)
    }
}

