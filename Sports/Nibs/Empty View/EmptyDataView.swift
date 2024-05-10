//
//  EmptyDataView.swift
//  FootballApp
//
//  Created by ios dev on 26/04/2024.
//

import UIKit

class EmptyDataView: UIView {

    @IBOutlet weak var emptyImg: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var messageLb: UILabel!
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
        emptyImg.image = UIImage(named: imageName)
        titleLb.text = title
        messageLb.text = message
    }
    func setupViewConstraint(vu: UIView)
    {
        vu.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        vu.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .trailing, relatedBy: .equal, toItem: vu, attribute: .trailing, multiplier: 1, constant: 0))
        vu.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .leading, relatedBy: .equal, toItem: vu, attribute: .leading, multiplier: 1, constant: 0))
        vu.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .top, relatedBy: .equal, toItem: vu, attribute: .top, multiplier: 1, constant: 0))
        vu.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .bottom, relatedBy: .equal, toItem: vu, attribute: .bottom, multiplier: 1, constant: 0))
    }
    //MARK: - func delete empty case
    func deleteView() {
        self.removeFromSuperview()
    }
}
