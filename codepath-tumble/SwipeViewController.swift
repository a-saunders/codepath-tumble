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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).CGColor
        cardView.layer.cornerRadius = 4;
        cardView.layer.masksToBounds = true;
        
        imageView.layer.cornerRadius = 2;
        
        cardView.layer.shadowColor = UIColor.blackColor().CGColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = CGSizeZero
        cardView.layer.shadowRadius = 10
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
            
            //If card is swiped to the right and above image center
            if translation.x > 0 && (point.y) < cardInitialCenter.y {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardView.transform = CGAffineTransformMakeRotation(translation.x * 11.25 / 160 * CGFloat(M_PI / 180))
                })
                
            //If card is swiped to the right and below image center
            } else if translation.x > 0 && (point.y) > cardInitialCenter.y {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardView.transform = CGAffineTransformMakeRotation(translation.x * -11.25 / 160 * CGFloat(M_PI / 180))
                })
                
            //If card is swiped to the left and above image center
            } else if translation.x < 0 && (point.y) < cardInitialCenter.y {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardView.transform = CGAffineTransformMakeRotation(translation.x * 11.25 / 160 * CGFloat(M_PI / 180))
                })
                
            //If card is swiped to the left and below image center
            } else if translation.x < 0 && (point.y) > cardInitialCenter.y {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardView.transform = CGAffineTransformMakeRotation(translation.x * -11.25 / 160 * CGFloat(M_PI / 180))
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
                        self.cardView.transform = CGAffineTransformMakeTranslation(250,0)
                    })
                    
                }
                    
                else if translation.x < 100 {
                    UIView.animateWithDuration(0.4, animations: {
                        self.cardView.transform = CGAffineTransformMakeTranslation(-250,0)
                    })
                }
        }
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
