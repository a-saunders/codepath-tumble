//
//  SwipeViewController.swift
//  codepath-tumble
//
//  Created by Alexandra Saunders on 6/22/16.
//  Copyright © 2016 red58 Communications. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet var cardPanRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var imageView: UIScrollView!
    
    var cardInitialCenter: CGPoint!



    @IBAction func didPanCard(sender: UIPanGestureRecognizer) {
        
        // Absolute (x,y) coordinates in card view
        var point = cardPanRecognizer.locationInView(view)
        
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = cardPanRecognizer.translationInView(view)
        var velocity = cardPanRecognizer.velocityInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            cardInitialCenter = cardView.center

            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            // If pan input x value changes, move Message View
            cardView.center.x = cardInitialCenter.x + translation.x
            cardView.center.y = cardInitialCenter.y + translation.y
            
            if translation.x > 0 {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardView.transform = CGAffineTransformMakeRotation(CGFloat(11.25 * M_PI / 180))
                })
            }
                
            else if translation.x < 0 {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardView.transform = CGAffineTransformMakeRotation(CGFloat(-11.25 * M_PI / 180))
                })
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
                
                // move messageImage back to original point
                
                if (abs(translation.x) <= 100) {
                    UIView.animateWithDuration(0.4, animations: {
                        self.cardView.center.x = self.cardInitialCenter.x
                        self.cardView.center.y = self.cardInitialCenter.y
                        self.cardView.transform = CGAffineTransformIdentity
                    })
                    
                } else if translation.x > 100 {
                    UIView.animateWithDuration(0.4, animations: {
                        self.cardView.transform = CGAffineTransformMakeTranslation(400,0)
                    })
                    
                }
                    
                else if translation.x < 100 {
                    UIView.animateWithDuration(0.4, animations: {
                        self.cardView.transform = CGAffineTransformMakeTranslation(-400,0)
                    })
                }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).CGColor
        cardView.layer.cornerRadius = 8;
        cardView.layer.masksToBounds = true;
        
        imageView.layer.cornerRadius = 5;

       

        
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
