//
//  MessagesViewController.swift
//  codepath-tumble
//
//  Created by Alexandra Saunders on 6/22/16.
//  Copyright © 2016 red58 Communications. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var typingView: UIView!
    
    var typingInitialY: CGFloat!
    var typingOffset: CGFloat!
    var scrollViewInitialY: CGFloat!
    var scrollViewOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 568)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
        typingInitialY = typingView.frame.origin.y
        typingOffset = -220
        
        scrollViewInitialY = scrollView.frame.origin.y
        scrollViewOffset = -220
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        typingView.frame.origin.y = typingInitialY + typingOffset
        scrollView.frame.origin.y = scrollViewInitialY  + scrollViewOffset
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // If the scrollView has been scrolled down by 50px or more...
        if scrollView.contentOffset.y >= 20 {
            // Hide the keyboard
            view.endEditing(true)
            UIView.animateWithDuration(0.35) { () -> Void in
                self.typingView.frame.origin.y = self.typingInitialY
                self.scrollView.frame.origin.y = self.scrollViewInitialY
            }
        }
    }
    @IBAction func didTapOff(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        UIView.animateWithDuration(0.35) { () -> Void in
            self.typingView.frame.origin.y = self.typingInitialY
            self.scrollView.frame.origin.y = self.scrollViewInitialY
        }
    }
    
    @IBAction func onBack(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }

    @IBAction func didTapSend(sender: AnyObject) {
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
