//
//  PostDetailsViewController.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userUserNameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postLikeButton: UIButton!
    @IBOutlet weak var postLikesCountLabel: UILabel!
    
    @IBOutlet weak var postCommentsButton: UIButton!
    @IBOutlet weak var postCommentsCountLabel: UILabel!
    
    @IBOutlet weak var postShareButton: UIButton!
    @IBOutlet weak var postOptionsButton: UIButton!

    // MARK: Properties
    var presenter: PostDetailsPresenterProtocol?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let image = postImage.image else { return }
        presenter?.didSelectTappedImage(image: image)
    }
}

extension PostDetailsViewController: PostDetailsControllerProtocol {
    
    func configurePostUI(with post: Post?) {
        title = "Post Details".localized
        userNameLabel.text = post?.user.name
        userUserNameLabel.text = post?.user.name
        
        postContentLabel.text = post?.content
        postLikesCountLabel.text = "22"
        postCommentsCountLabel.text = "12"
        
        post?.imageURL?.isValidURL ?? false ? (loadImages(loadImage: postImage, from: post?.imageURL)) : (postImage.isHidden = true)
    }
    
}

