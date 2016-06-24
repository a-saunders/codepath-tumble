//
//  ImageGalleryViewController.swift
//  codepath-tumble
//
//  Created by Stephen Davis on 6/23/16.
//  Copyright © 2016 red58 Communications. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController {

    @IBOutlet weak var imageLoaded: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var image: UIImage!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize (width: 320, height: 1000)
        imageLoaded.image = image
        scrollView.backgroundColor = UIColor(white: 0, alpha: 1)



        
        // Set initial properties as a basis to have them changed
        
        

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
