//
//  FullPhotoViewController.swift
//  MyPhotos
//
//  Created by Carlos Poles on 6/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

protocol FullPhotoViewControllerDelegate {
    func nextItemFor(viewController: FullPhotoViewController)
    func previousItemFor(viewController: FullPhotoViewController)
}

class FullPhotoViewController: UIViewController {

    @IBOutlet weak var imgFullPhoto: UIImageView!
    
    // MARK - Properties
    
    var delegate: FullPhotoViewControllerDelegate?
    var delegate2: DetailViewControllerDelegate?
    
    var detailItem: AnyObject? {
        didSet {
            self.configureView()
            print("Detail Item was set.")
        }
    }
    
    var photo: Photo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        if let photoItem = self.detailItem as? Photo {
            photo = photoItem
            if let data = NSData(contentsOfURL: NSURL(string: (photo?.url)!)!) {
                photo?.imageData = data
                if let image = self.imgFullPhoto {
                    image.image = UIImage(data: data)
                }
                
            }
            print("Photo is not nil")
        } else {
            print("photo is nil")
        }
    }
    
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let controller = segue.destinationViewController  as! DetailViewController
            controller.detailItem = self.detailItem
            controller.delegate = self.delegate as? DetailViewControllerDelegate
        }
    }
    
    // MARK: - Actions
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        delegate?.previousItemFor(self)
        
    }
        
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        
        delegate?.nextItemFor(self)
    }

}
