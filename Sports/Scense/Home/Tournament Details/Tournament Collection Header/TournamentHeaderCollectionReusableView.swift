//
//  TournamentHeaderCollectionReusableView.swift
//  Sports
//
//  Created by ios Dev on 05/06/2024.
//

import UIKit

class TournamentHeaderCollectionReusableView: UICollectionReusableView {

    var headerImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "header"))
        image.contentMode = .scaleAspectFill
        image.isHeroEnabled = true
        image.heroID = "headerID"
        return image
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0
        return blurView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        contentView.addSubview(headerImageView)
        
//        contentView.fillSuperview()  // Assuming you have an extension or method to handle layout
//        headerImageView.fillSuperview()  // Assuming you have an extension or method to handle layout
        setupViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeaderUI() {
        headerImageView.image = UIImage(named: "header")
    }
    
    private func setupViews() {
        addSubview(headerImageView)
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

