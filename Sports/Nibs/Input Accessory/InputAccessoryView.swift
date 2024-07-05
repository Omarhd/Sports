//
//  InputAccessoryView.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//

import UIKit

protocol InputAccessoryViewControllerDelegate: AnyObject {
    func uploadImage()
    func takeImage()
    func doneTyping()
}

class InputAccessoryView: UIView {

    // MARK: - Outlets
    @IBOutlet var contentView: UIView!

    // MARK: - Properties
    weak var delegate: InputAccessoryViewControllerDelegate?
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
       // deleteView()
        commit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commit()
    }

    func commit(){
        Bundle.main.loadNibNamed("InputAccessoryView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
    }

    @IBAction func cameraImageAction(_ sender: Any) {
        delegate?.takeImage()
    }
    @IBAction func galleryImageAction(_ sender: Any) {
        delegate?.uploadImage()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        delegate?.doneTyping()
    }
    
}
