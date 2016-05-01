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
    
    var photoCollection = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the navigation bar background colour as black
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // Append photos to the array.
        
        // Load any saved photos, otherwise, load the sample photoCollection
        
        if let savedPhotoCollection = loadPhotoCollection() {
                photoCollection += savedPhotoCollection
        } else {
            // Load the sample photos
            loadSamplePhotos()
        }
        
        for photo in photoCollection {
            loadPhotoInBackground(photo)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoCollection.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // create cell as CollectionViewCell object
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! CollectionViewCell
        if let picture =  photoCollection[indexPath.row].imageData {
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
            destinationViewController.detailItem = photoCollection[indexPath.row]
            destinationViewController.delegate = self
            print("Show Detail")
        } else if segue.identifier == "addPhoto" {
            let photo = Photo(url: "")
            photo.imageData = nil
            photoCollection.append(photo)
            let controller = segue.destinationViewController as! DetailViewController
            controller.detailItem = photo
            controller.delegate = self
            print("Add new contact")
            
        }
    }
    
    
    // MARK: - Methods
    
    /**
        This function allows control back to the user, while downloading the photos on the background.
     
        parameters: (_:Photo)
        - returns: - Void
     
     
     */
    
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
    
    func loadPhotoCollection() -> [Photo]? {
        
        // build the photo collection for the jsonFile
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
        // creating path and looking for file.
        
        let jsonFile = path.stringByAppendingPathComponent("photoCollection.json")
        
        // create NSData object
        let jsonData = NSData(contentsOfFile: jsonFile)
        
        // create the array of dictionaries out of the jsonData NSData object
        
        let jsonArrayDic: [NSDictionary]
        
        try! jsonArrayDic = NSJSONSerialization.JSONObjectWithData(jsonData!, options: []) as! [NSDictionary]
        
        // create the array of Photo objects parsing a trailing closure to the map function of the jsonArrayDic
        // The closure will build a Photo object for each dictionary inside the jsonArrayDic
        
        let loadedPhotoCollection = jsonArrayDic.map { Photo(propertyList: $0) }
        
        return loadedPhotoCollection

        
    }
    
    func savePhotoCollection() {

        
        // create path from Directory for the class for the converted class into a property list to be saved.
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
        
        // convert array into NSDictionary format
        
        let arrayPhotoDic = photoCollection.map { $0.propertyListRepresentation() }
        
        // create NSData object to write data to file
        let data: NSData
        try! data = NSJSONSerialization.dataWithJSONObject(arrayPhotoDic, options: .PrettyPrinted)
        
        // create json file
        
        let jsonFile = path.stringByAppendingPathComponent("photoCollection.json")
        
        //write data to file
        
       data.writeToFile(jsonFile, atomically: true)

        
    }
    
    func loadSamplePhotos() {
        
        // append default photos
        photoCollection.append(Photo(title: "QUT", url: "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Queensland_University_of_Technology_(logo).svg/1017px-Queensland_University_of_Technology_(logo).svg.png", tags: ["qut", "queensland", "university"]))
        photoCollection.append(Photo(title: "Griffith University", url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png", tags: ["griffith", "queensland", "university"]))
        photoCollection.append(Photo(title: "ACU", url: "http://www.pccevents.com.au/wp-content/uploads/2011/03/logo-acu-small.jpg", tags: ["catholic", "queensland", "university"]))
    }
    
    
    // MARK: - UIDetailViewControllerDelegate
    
    func destinationViewControllerContentChanged(destinationViewController: DetailViewController) {
        if let photo = destinationViewController.detailItem {
            print("Got \(photo)")
            
            // append the photo to the collection
            photoCollection.append(photo as! Photo)
            
            // save the photo collection and write to the json file
            savePhotoCollection()
            
            dismissViewControllerAnimated(true, completion: nil)
            // reload the new picture in the background
            loadPhotoInBackground(photo as! Photo)
        }
        // refresh the collection view.
        self.collectionView?.reloadData()
    }
    
} // end of MasterViewController Class

