//
//  ImageViewerViewController.swift
//  Sports
//
//  Created by ios Dev on 12/06/2024.
//

import UIKit

class ImageViewerViewController: UIViewController {

    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: "ImageViewerViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        imageViewer.image = image
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let image = imageViewer.image
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func optionAction(_ sender: Any) {
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
