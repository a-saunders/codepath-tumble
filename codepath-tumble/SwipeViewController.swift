//
//  SwipeViewController.swift
//  codepath-tumble
//
//  Created by Alexandra Saunders on 6/22/16.
//  Copyright © 2016 red58 Communications. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var cardPanRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    var cardToPan: UIView!
    var cardToPanCenter: CGPoint!

    var cardPanGestureRecognizer: UIPanGestureRecognizer!
    var cardInitialCenter: CGPoint!
    var currentPotentialMatch = users[5]
    var imageName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
/*
        scrollView.contentSize = CGSize(width: 288, height: 2000)

        // Set text data
        nameAgeLabel.text = "\(currentPotentialMatch["name"]!), \(currentPotentialMatch["age"]!)"
        occupationLabel.text = "\(currentPotentialMatch["job"]!)"
        educationLabel.text = "\(currentPotentialMatch["education"]!)"
        imageName = "\(currentPotentialMatch["name"]!)"
        profileImage.image = UIImage(named: "\(imageName.lowercaseString)-128x128")

        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).CGColor
        cardView.layer.cornerRadius = 8;
        cardView.layer.masksToBounds = true;
        cardView.layer.shadowColor = UIColor.blackColor().CGColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = CGSizeZero
        cardView.layer.shadowRadius = 10

        scrollView.layer.cornerRadius = 2;

        panGestureRecognizer.delegate = self

        // Do any additional setup after loading the view.
        // Just create all the cards here, and let swiping
        // revel the cards lower in the stack
        for user in users {
            print("\(user)")
        }
 */

        for user in users {
            cardPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPanCard:")
            cardPanGestureRecognizer.delegate = self
            let userCard = createCard(user)
            userCard.addGestureRecognizer(cardPanGestureRecognizer)
            view.addSubview(userCard)
        }
    }

    func createCard(user: Dictionary<String, protocol<>>) -> UIView {
        // Create parent card view
        let userCardView = UIView()
        userCardView.frame = CGRectMake(10, 65, 300, 480)
        userCardView.backgroundColor = UIColor.whiteColor()
        userCardView.layer.cornerRadius = 10
        userCardView.layer.borderColor = UIColor.lightGrayColor().CGColor;
        userCardView.layer.borderWidth = 1;

        // Add image
        let profileImageView: UIImageView = UIImageView()
        profileImageView.frame = CGRectMake(10, 10, 280, 380)
        profileImageView.contentMode = .ScaleAspectFit

        let imageName = "\(user["name"]!)"
        profileImageView.image = UIImage(named: "\(imageName.lowercaseString)-128x128")
        userCardView.addSubview(profileImageView)

        // Create Name, Age label
        let nameAgeLabel: UILabel = UILabel()
        nameAgeLabel.frame = CGRectMake(20, 400, 260, 22)
        nameAgeLabel.backgroundColor = UIColor.whiteColor()
        nameAgeLabel.textColor = UIColor.blackColor()
        nameAgeLabel.textAlignment = NSTextAlignment.Left
        nameAgeLabel.font = nameAgeLabel.font.fontWithSize(22)
        nameAgeLabel.text = "\(user["name"]!), \(user["age"]!)"
        userCardView.addSubview(nameAgeLabel)
        
        // Create Occupation label
        let occupationLabel: UILabel = UILabel()
        occupationLabel.frame = CGRectMake(20, 430, 260, 14)
        occupationLabel.backgroundColor = UIColor.whiteColor()
        occupationLabel.textColor = UIColor.lightGrayColor()
        occupationLabel.textAlignment = NSTextAlignment.Left
        occupationLabel.font = occupationLabel.font.fontWithSize(12)
        occupationLabel.text = "\(user["job"]!)"
        userCardView.addSubview(occupationLabel)

        // Create Education label
        let educationLabel: UILabel = UILabel()
        educationLabel.frame = CGRectMake(20, 444, 260, 14)
        educationLabel.backgroundColor = UIColor.whiteColor()
        educationLabel.textColor = UIColor.lightGrayColor()
        educationLabel.textAlignment = NSTextAlignment.Left
        educationLabel.font = educationLabel.font.fontWithSize(12)
        educationLabel.text = "\(user["education"]!)"
        userCardView.addSubview(educationLabel)

        return userCardView
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let panGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
        
        let velocity = panGestureRecognizer.velocityInView(view)
        
        if abs(velocity.x) > abs(velocity.y) {
            return true
        } else {
            return false
        }
    }

    @IBAction func didPanCard(sender: UIPanGestureRecognizer) {

        // Absolute (x,y) coordinates in card view
        let point = cardPanGestureRecognizer.locationInView(view)

        // Relative change in (x,y) coordinates from where gesture began.
        let translation = cardPanGestureRecognizer.translationInView(view)
        let velocity = cardPanGestureRecognizer.velocityInView(view)

        if sender.state == UIGestureRecognizerState.Began {

            cardToPan = sender.view
            cardToPanCenter = cardToPan.center

        } else if sender.state == UIGestureRecognizerState.Changed {

            // If pan input x value changes, move Message View
            cardToPan.center.x = cardToPanCenter.x + translation.x
            cardToPan.center.y = cardToPanCenter.y + translation.y
            
            //If card is swiped to the right and above image center
            if translation.x > 0 && (point.y) < cardToPanCenter.y {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardToPan.transform = CGAffineTransformMakeRotation(translation.x * 11.25 / 160 * CGFloat(M_PI / 180))
                })
                
                //If card is swiped to the right and below image center
            } else if translation.x > 0 && (point.y) > cardToPanCenter.y {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardToPan.transform = CGAffineTransformMakeRotation(translation.x * -11.25 / 160 * CGFloat(M_PI / 180))
                })
                
                //If card is swiped to the left and above image center
            } else if translation.x < 0 && (point.y) < cardToPanCenter.y {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardToPan.transform = CGAffineTransformMakeRotation(translation.x * 11.25 / 160 * CGFloat(M_PI / 180))
                })
                
                //If card is swiped to the left and below image center
            } else if translation.x < 0 && (point.y) > cardToPanCenter.y {
                UIView.animateWithDuration(0.2, animations: {
                    self.cardToPan.transform = CGAffineTransformMakeRotation(translation.x * -11.25 / 160 * CGFloat(M_PI / 180))
                })
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            // move messageImage back to original point
            if (abs(translation.x) <= 100) {
                UIView.animateWithDuration(0.4, animations: {
                    self.cardToPan.center.x = self.cardToPanCenter.x
                    self.cardToPan.center.y = self.cardToPanCenter.y
                    self.cardToPan.transform = CGAffineTransformIdentity
                })
                
            } else if translation.x > 100 {
                UIView.animateWithDuration(0.4, animations: {
                    self.cardToPan.transform = CGAffineTransformMakeTranslation(250,0)
                })
                
            }
                
            else if translation.x < 100 {
                UIView.animateWithDuration(0.4, animations: {
                    self.cardToPan.transform = CGAffineTransformMakeTranslation(-250,0)
                })
            }
        }
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
