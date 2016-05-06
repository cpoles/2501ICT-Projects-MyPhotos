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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
