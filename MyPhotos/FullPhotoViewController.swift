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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
