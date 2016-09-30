//
//  ViewController.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController, DetailViewControllerDelegate, FullPhotoViewControllerDelegate {
    
    // MARK: - Properties
    
    var photoCollection = [Photo]()
    var currentIndexPath = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the navigation bar background colour as black
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
        
        // Load any saved photos, otherwise, load the sample photoCollection
        
        if let savedPhotoCollection = loadPhotoCollection() {
                photoCollection += savedPhotoCollection
            for photo in photoCollection {
                loadPhotoInBackground(photo)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoCollection.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // create cell as CollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        if let picture =  photoCollection[(indexPath as NSIndexPath).row].imageData {
            cell.imageCell.image = UIImage(data: picture as Data)
        }
        return cell
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFullPhoto" {
            let destinationViewController = segue.destination as! FullPhotoViewController
            let indexPaths = self.collectionView?.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as IndexPath
            currentIndexPath = indexPath
            destinationViewController.detailItem = photoCollection[(indexPath as NSIndexPath).row]
            destinationViewController.delegate = self
            print("Show Detail")
        } else if segue.identifier == "addPhoto" {
            let photo = Photo(url: "")
            photo.imageData = nil
            photoCollection.append(photo)
            let controller = segue.destination as! DetailViewController
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
    
    func loadPhotoInBackground(_ photo: Photo) {
        let queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.low)
        
        // closure to be run in the background on the secondary queue
        let backgroundDownload = {
            if let data = try? Data(contentsOf: URL(string: photo.url)!) {
                // the UIView objects MUST run in the main thread. 
                let mainQueue = DispatchQueue.main
                // dispatch items assincronously.
                mainQueue.async {
                    photo.imageData = data
                    self.collectionView?.reloadData()
                }
            } else {
                print("Could not download page \(photo.url)")
            }
        }
        
        queue.async(execute: backgroundDownload)
    }
    
    func loadPhotoCollection() -> [Photo]? {
        
        var photoLoaded = [Photo]()
        // build the photo collection for the jsonFile
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        // creating path and looking for file.
        
        let jsonFile = path.appendingPathComponent("photoCollection.json") as String?
        
        if let file = jsonFile {
            
            // create NSData object
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
            
            // create the array of dictionaries out of the jsonData NSData object
            
            let jsonArrayDic: [NSDictionary]
            
            if let data = jsonData {
                
                try! jsonArrayDic = JSONSerialization.jsonObject(with: data, options: []) as! [NSDictionary]
                // create the array of Photo objects parsing a trailing closure to the map function of the jsonArrayDic
                // The closure will build a Photo object for each dictionary inside the jsonArrayDic
                
                let loadedPhotoCollection = jsonArrayDic.map { Photo(propertyList: $0) }
                 photoLoaded = loadedPhotoCollection
            }
        }
        return photoLoaded
}
    
    func savePhotoCollection() {

        // create path from Directory for the class for the converted class into a property list to be saved.
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        
        // convert array into NSDictionary format
        
        let arrayPhotoDic = photoCollection.map { $0.propertyListRepresentation() }
        
        // create NSData object to write data to file
        let data: Data
        try! data = JSONSerialization.data(withJSONObject: arrayPhotoDic, options: .prettyPrinted)
        
        // create json file
        
        let jsonFile = path.appendingPathComponent("photoCollection.json")
        
        //write data to file
        
       try? data.write(to: URL(fileURLWithPath: jsonFile), options: [.atomic])
    }
    
    // MARK: - Delegation
    
    // MARK: - UIDetailViewControllerDelegate
    
    /**
        This function handles the changes ocurred in the contents of the destinationViewController, the Detail View.
     
        - parameters:
            - destinationViewController: DetailViewController
        - returns: Void
 
    */
    
    func destinationViewControllerContentChanged(_ destinationViewController: DetailViewController) {
        if let photo = destinationViewController.detailItem {
            print("Got \(photo)")
             
            // save the photo collection and write to the json file
            savePhotoCollection()
            loadPhotoCollection()
            
            dismiss(animated: true, completion: nil)
            // reload the new picture in the background
            loadPhotoInBackground(photo as! Photo)
        }
        // refresh the collection view.
        self.collectionView?.reloadData()
    }
    
    /**
     This function handles deletes a photo from the photoCollection requested by the Detail ViewController.
     
     - parameters:
        - destinationViewController: DetailViewController
     - returns: Void
     
     */
    
    func deletePhoto(_ destinationViewController: DetailViewController) {
        
        if let photo = destinationViewController.detailItem {
            
            let index = photoCollection.index(where: { $0 == photo as! Photo  })
            
            photoCollection.remove(at: index!)
            
            dismiss(animated: true, completion: nil)
            print("item deleted.")
        
        }
        // refresh the collection view.
        savePhotoCollection()
        self.collectionView?.reloadData()
    }
    
    // MARK: - FullPhotoViewControllerDelegate
    
    func nextItemFor(_ viewController: FullPhotoViewController) {
        
        let row = (currentIndexPath as NSIndexPath).row
        let nextRow: Int
        if row == photoCollection.count - 1 { nextRow = 0 }
        else { nextRow = row + 1 }
        let indexPath = IndexPath(row: nextRow, section: (currentIndexPath as NSIndexPath).section)
        currentIndexPath = indexPath
        viewController.detailItem = photoCollection[nextRow]
        
    }
    
    func previousItemFor(_ viewController: FullPhotoViewController) {
        let row = (currentIndexPath as NSIndexPath).row
        let previousRow: Int
        if row == 0 { previousRow = photoCollection.count - 1 }
        else { previousRow = row - 1 }
        let indexPath = IndexPath(row: previousRow, section: (currentIndexPath as NSIndexPath).section)
        currentIndexPath = indexPath
        viewController.detailItem = photoCollection[previousRow]
    }


} // end of MasterViewController Class

