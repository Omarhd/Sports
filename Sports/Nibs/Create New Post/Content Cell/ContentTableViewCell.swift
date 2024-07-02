//
//  ContentTableViewCell.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//

import UIKit

class ContentTableViewCell: UITableViewCell, ContentCellProtocol {

    // MARK: - Outlets
    @IBOutlet weak var postContent: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var removeImageButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: ImagePickerCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tapGesture)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI(with image: UIImage?) {
        postImage.image = image
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.didTapSelectImage(cell: self)
    }
    
    @IBAction func removeImageAction(_ sender: Any) {
        delegate?.didRemoveImage(cell: self)
    }
}
