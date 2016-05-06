//
//  FullPhotoViewController.swift
//  MyPhotos
//
//  Created by Carlos Poles on 6/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

/**
    This protocol allows for the delegate to move through the photoCollection displayed in the FullPhotoView
*/

protocol FullPhotoViewControllerDelegate {
    func nextItemFor(viewController: FullPhotoViewController)
    func previousItemFor(viewController: FullPhotoViewController)
}

class FullPhotoViewController: UIViewController {

    @IBOutlet weak var imgFullPhoto: UIImageView!
    
    // MARK - Properties
    
    var delegate: FullPhotoViewControllerDelegate?
    
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
    
    /**
        The configureView() function retrieves the detailItem sent by the sourceViewController, casts it down to a Photo object, checks for the imageData and sets the image property of the UIImageView to display the corresponding photo.
 
    */
    
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
            
            // cast this delegate as DetailViewControllerDelegate so the destinatationViewController can have the master view as its delegate.
            controller.delegate = self.delegate as? DetailViewControllerDelegate
        }
    }
    
    // MARK: - Actions
    
    /**
        swipeRight action calls the delegate to execute the move to the previous item of the photoCollection
        - parameters:
            - (sender: UISwipeGestureRecognizer)
     
    */
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        delegate?.previousItemFor(self)
        
    }
    
    /**
     swipeLeft action calls the delegate to execute the move to the next item of the photoCollection
     - parameters:
        - (sender: UISwipeGestureRecognizer)
     
     */
    
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        
        delegate?.nextItemFor(self)
    }

}
