//
//  ViewController.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController, DetailViewControllerDelegate {
    
    // MARK: - Properties
    
    var photoColletion = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the navigation bar background colour as black
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // Append photos to the array.
        
        photoColletion.append(Photo(title: "QUT", url: "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Queensland_University_of_Technology_(logo).svg/1017px-Queensland_University_of_Technology_(logo).svg.png", tags: ["qut", "queensland", "university"]))
        photoColletion.append(Photo(title: "Griffith University", url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png", tags: ["griffith", "queensland", "university"]))
        photoColletion.append(Photo(title: "ACU", url: "http://www.pccevents.com.au/wp-content/uploads/2011/03/logo-acu-small.jpg", tags: ["catholic", "queensland", "university"]))
        
        for photo in photoColletion {
            loadPhotoInBackground(photo)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoColletion.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // create cell as CollectionViewCell object
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! CollectionViewCell
        if let picture =  photoColletion[indexPath.row].imageData {
            cell.imageCell.image = UIImage(data: picture)
        }
        return cell
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let destinationViewController = segue.destinationViewController as! DetailViewController
            let indexPaths = self.collectionView?.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            destinationViewController.detailItem = photoColletion[indexPath.row]
            destinationViewController.delegate = self
            print("Show Detail")
        } else if segue.identifier == "addPhoto" {
            let photo = Photo(url: "")
            photo.imageData = nil
            photoColletion.append(photo)
            let controller = segue.destinationViewController as! DetailViewController
            controller.detailItem = photo
            controller.delegate = self
            print("Add new contact")
            
        }
    }
    
    
    // MARK: - Methods
    
    func loadPhotoInBackground(photo: Photo) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        
        // closure to be run in the background on the secondary queue
        let backgroundDownload = {
            if let data = NSData(contentsOfURL: NSURL(string: photo.url)!) {
                // the UIView objects MUST run in the main thread. 
                let mainQueue = dispatch_get_main_queue()
                // dispatch items assincronously.
                dispatch_async(mainQueue) {
                    photo.imageData = data
                    self.collectionView?.reloadData()
                }
            } else {
                print("Could not download page \(photo.url)")
            }
        }
        
        dispatch_async(queue, backgroundDownload)
    }
    
    // MARK: - UIDetailViewControllerDelegate
    
    func destinationViewControllerContentChanged(destinationViewController: DetailViewController) {
        if let photo = destinationViewController.detailItem {
            print("Got \(photo)")
            dismissViewControllerAnimated(true, completion: nil)
            // reload the new picture in the background
            loadPhotoInBackground(photo as! Photo)
        }
        // refresh the collection view.
        self.collectionView?.reloadData()
    }
    
} // end of MasterViewController Class

