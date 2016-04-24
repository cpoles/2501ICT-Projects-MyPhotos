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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set this detail view as the delegate for the text fields.
        
        textTitle.delegate = self
        textTags.delegate = self
        textUrl.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        
        textTitle.resignFirstResponder()
        textTags.resignFirstResponder()
        textUrl.resignFirstResponder()
        return true
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
