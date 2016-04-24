//
//  ViewController.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    var photoColletion = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Append photos to the array.
        
        photoColletion.append(Photo(title: "QUT", url: NSURL(string: "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Queensland_University_of_Technology_(logo).svg/1017px-Queensland_University_of_Technology_(logo).svg.png")!, tags: ["qut", "queensland", "university"]))
        photoColletion.append(Photo(title: "Griffith University", url: NSURL(string: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png")!, tags: ["griffith", "queensland", "university"]))
        photoColletion.append(Photo(title: "ACU", url: NSURL(string: "http://www.pccevents.com.au/wp-content/uploads/2011/03/logo-acu-small.jpg")!, tags: ["catholic", "queensland", "university"]))
        
        for photo in photoColletion {
            loadPhotoInBackground(photo)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Methods
    
    func loadPhotoInBackground(photo: Photo) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        
        // closure to be run in the background on the secondary queue
        let backgroundDownload = {
            if let data = NSData(contentsOfURL: photo.url) {
                // the UIView objects MUST run in the main thread. 
                let mainQueue = dispatch_get_main_queue()
                // dispatch items assincronously.
                dispatch_async(mainQueue, {
                    photo.imageData = data
                    self.collectionView?.reloadData()
                })
            } else {
                print("Could not download page \(photo.url)")
            }
        }
        
        dispatch_async(queue, backgroundDownload)
    }

}

