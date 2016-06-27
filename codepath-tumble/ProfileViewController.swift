//
//  ProfileViewController.swift
//  codepath-tumble
//
//  Created by Alexandra Saunders on 6/22/16.
//  Copyright © 2016 red58 Communications. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileCard: UIView!
    var fadeTransition: FadeTransition!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileCard.layer.borderWidth = 1
        profileCard.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).CGColor
        profileCard.layer.cornerRadius = 4;
        profileCard.layer.masksToBounds = true;

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapImage(sender: UITapGestureRecognizer) {
        
        imageView = sender.view as! UIImageView
        
        performSegueWithIdentifier("ImageGallerySegue", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!){
        

        let destinationViewController = segue.destinationViewController as! ImageGalleryViewController
        
        // Access the image to display
        
        destinationViewController.image = self.imageView.image
        
        
        // Set the modal presentation style of your destinationViewController to be custom.
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        // Create a new instance of your fadeTransition.
        fadeTransition = FadeTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        destinationViewController.transitioningDelegate = fadeTransition
        // Adjust the transition duration. (seconds)
        fadeTransition.duration = 1.0
    }
}

