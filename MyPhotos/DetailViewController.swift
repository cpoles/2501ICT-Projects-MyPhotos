//
//  DetailViewController.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    
    @IBOutlet weak var textTitle: UITextField!
    
    @IBOutlet weak var textTags: UITextField!
    
    @IBOutlet weak var textUrl: UITextField!
    
    @IBOutlet weak var imagePhoto: UIImageView!
    
    var detailItem: AnyObject? {
        didSet {
            
        }
    }
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set this detail view as the delegate for the text fields.
        
        textTitle.delegate = self
        textTags.delegate = self
        textUrl.delegate = self
        
        self.configureview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        
        textTitle.resignFirstResponder()
        textTags.resignFirstResponder()
        textUrl.resignFirstResponder()
        return true
    }
    
    // MARK: - Methods
    
    func configureview() {
        //set the object to be displayed as Photo object
        photo = self.detailItem as? Photo
        
        if let title = self.textTitle, let tags = self.textTags, let url = self.textUrl,
            let image = self.imagePhoto {
            // load textBoxes with corresponding data
            title.text = photo!.title
            
            // handling url data to be printable as scring
            let urlString = photo!.url
            url.text = urlString.absoluteString
            
            // handling the tag property so it can be printed as string
            var tagString = ""
            
            for tag in (photo!.tags)! {
              tagString += "\(tag)" + ", "
            
            }
            tags.text = tagString
            
            // handling the photo image data so it can be displayed as UIImage
            
            let photoImage = NSData(contentsOfURL: (photo?.url)!)
            image.image = UIImage(data: photoImage!)
            
        }
        print("View Refreshed")
    }
    
    
    

}
