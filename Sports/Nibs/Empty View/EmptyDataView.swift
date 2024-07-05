//
//  EmptyDataView.swift
//  FootballApp
//
//  Created by ios dev on 26/04/2024.
//

import UIKit

class EmptyDataView: UIView {

    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // deleteView()
        commit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
      //  deleteView()
        commit()
    }

    func commit(){
        Bundle.main.loadNibNamed("EmptyDataView", owner: self, options: nil)
        self.tag = 100
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
    }
    
    // MARK: - func of add loader
    func setupView(imageName: String, title: String, message: String) {
        imageName == "" ? (emptyImage.image = UIImage(systemName: "figure.basketball")) : (emptyImage.image = UIImage(systemName: imageName))
        title == "" ? (titleLabel.text = "Yikes, Error".localized) : (titleLabel.text = title)
        message == "" ? (messageLabel.text = "Unable to get Data from Server for Now, try again Later.".localized) : (messageLabel.text = message)
        if #available(iOS 17.0, *) {
            configureImage()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 17.0, *)
    private func configureImage() {
        emptyImage.addSymbolEffect(.pulse)
    }
    
    func setupViewConstraint(view: UIView) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    //MARK: - func delete empty case
    func deleteView() {
        self.removeFromSuperview()
    }
}
