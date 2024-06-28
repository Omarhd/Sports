//
//  PostsTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//

import UIKit
import Kingfisher

class PostsTableViewCell: UITableViewCell, PostCellProtocol {

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
    
    weak var delegate: PostCellViewControllerProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let image = postImage.image else { return }
        delegate?.didTappedImage(image: image)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with pos: Post?) {
        userNameLabel.text = pos?.user.name
        userUserNameLabel.text = pos?.user.username
        
        postContentLabel.text = pos?.content
        postLikesCountLabel.text = "22"
        postLikesCountLabel.text = "12"
        
        guard let imageURL: URL = URL(string: pos?.imageURL ?? "") else { return }
//        postImage.kf.setImage(with: imageURL, placeholder: UIImage(systemName: "basketball"))
    }
    
}
