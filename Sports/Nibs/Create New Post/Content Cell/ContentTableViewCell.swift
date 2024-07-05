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

        // Initialize InputAccessoryView
        let inputAccessoryView = InputAccessoryView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 60))
        inputAccessoryView.delegate = self
        postContent.inputAccessoryView = inputAccessoryView

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
        postImage.image == nil ? (postImage.isHidden = true) : (postImage.isHidden = false)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.didTapSelectImage(cell: self)
    }
    
    @IBAction func removeImageAction(_ sender: Any) {
        delegate?.didRemoveImage(cell: self)
    }
}

extension ContentTableViewCell: InputAccessoryViewControllerDelegate {
    
    // MARK: - InputAccessoryViewControllerDelegate methods
    func uploadImage() {
        delegate?.didTapLibraryImage(cell: self)
    }

    func takeImage() {
        delegate?.didTapCameraImage(cell: self)
    }
    
    func doneTyping() {
        contentView.endEditing(true)
    }
}
