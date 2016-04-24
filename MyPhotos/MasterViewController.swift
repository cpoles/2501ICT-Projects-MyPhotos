//
//  ViewController.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {
    
    var photoColletion = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        photoColletion.append(Photo(title: "QUT", url: NSURL(string: "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Queensland_University_of_Technology_(logo).svg/1017px-Queensland_University_of_Technology_(logo).svg.png")!, tags: ["qut", "queensland", "university"]))
        photoColletion.append(Photo(title: "Griffith University", url: NSURL(string: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png")!, tags: ["griffith", "queensland", "university"]))
        photoColletion.append(Photo(title: "ACU", url: NSURL(string: "http://www.pccevents.com.au/wp-content/uploads/2011/03/logo-acu-small.jpg")!, tags: ["catholic", "queensland", "university"]))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

