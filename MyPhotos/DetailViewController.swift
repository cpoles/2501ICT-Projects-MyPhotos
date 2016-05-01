//
//  DetailViewController.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func destinationViewControllerContentChanged(destinationViewController: DetailViewController)
    func deletePhoto(destinationViewController: DetailViewController)
}

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    
    @IBOutlet weak var textTitle: UITextField!
    
    @IBOutlet weak var textTags: UITextField!
    
    @IBOutlet weak var textUrl: UITextField!
    
    @IBOutlet weak var imagePhoto: UIImageView!
    
    var detailItem: AnyObject? {
        didSet {
            self.configureview()
            print("Detail Item was set.")
        }
    }
    
    var photo: Photo?
    
    var delegate: DetailViewControllerDelegate?
    
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
            
            // handling url data to be printable as string
            let urlString = photo!.url
            url.text = urlString
            
            // handling the tag property so it can be printed as string
            let tagString =  photo?.tags?.joinWithSeparator(",")
            tags.text = tagString
            
            // handling the photo image data so it can be displayed as UIImage
            
            if let photoImage = NSData(contentsOfURL: NSURL(string: photo!.url)!) {
                image.image = UIImage(data: photoImage)
            } 
            
        }
        print("View Refreshed")
    }
    
    
    
    @IBAction func buttonBack(sender: UIBarButtonItem) {
        
        //rebuilding the object before go back to MasterViewController
        
        photo?.title = textTitle.text
        
        // retrieve url from the text field
        let urlString = textUrl.text
        photo?.url = urlString!
        
        // retrieve tags from the text field and convert it to an array
        let tagsString = textTags.text
        let tags = tagsString?.componentsSeparatedByString(",")
        photo?.tags = tags
        
        // send delegate a message saying that the content of the destViewController has changed.
        delegate?.destinationViewControllerContentChanged(self)
        print("back to the main view...")
    }
    
    @IBAction func buttonDelete(sender: UIBarButtonItem) {
        let title = "\(photo!.title)"
        let alertVC = UIAlertController(title: "Delete \(title)?", message: "Are you sure? It will be permanently lost.", preferredStyle: .ActionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) { (action: UIAlertAction) in
            print("delete pressed")
            self.delegate?.deletePhoto(self)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action: UIAlertAction) in
            self.dismissViewControllerAnimated(true, completion: nil)
            print("Cancelling...")
        }
        alertVC.addAction(deleteAction)
        alertVC.addAction(cancelAction)
        presentViewController(alertVC, animated: true) {
            print("Showing AlertVC")
        }
    }

   
}
