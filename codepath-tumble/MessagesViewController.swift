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
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var noMessageImage: UIImageView!
    
    var selectedImage : UIImage?
    var lastChatBubbleY: CGFloat = 10.0
    var internalPadding: CGFloat = 8.0
    var lastMessageType: BubbleDataType?
    
    var typingInitialY: CGFloat!
    var typingOffset: CGFloat!
    var scrollViewInitialY: CGFloat!
    var scrollViewOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendButton.enabled = false
        
//        scrollView.contentSize = CGSize(width: 320, height: 400)
        
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
        self.moveToLastMessage()
        typingView.frame.origin.y = typingInitialY + typingOffset
//        scrollView.frame.origin.y = scrollViewInitialY  + scrollViewOffset
        sendButton.enabled = true
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        self.moveToLastMessage()
    }
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        // If the scrollView has been scrolled down by 50px or more...
//        if scrollView.contentOffset.y >= 20 {
//            // Hide the keyboard
//            view.endEditing(true)
//            UIView.animateWithDuration(0.35) { () -> Void in
//                self.typingView.frame.origin.y = self.typingInitialY
//                self.scrollView.frame.origin.y = self.scrollViewInitialY
//            }
//        }
//    }
    
    @IBAction func didTapOff(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        UIView.animateWithDuration(0.35) { () -> Void in
            self.typingView.frame.origin.y = self.typingInitialY
//            self.scrollView.frame.origin.y = self.scrollViewInitialY
            self.moveToLastMessage()
        }
    }
    
    @IBAction func onBack(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }

    @IBAction func didTapSend(sender: AnyObject) {
        self.addRandomTypeChatBubble()
        textField.resignFirstResponder()
        UIView.animateWithDuration(0.35) { () -> Void in
            self.typingView.frame.origin.y = self.typingInitialY

        }
    }
    
    func addRandomTypeChatBubble() {
        let bubbleData = ChatBubbleData(text: textField.text, image: selectedImage, date: NSDate(), type: .Mine)
        addChatBubble(bubbleData)
        noMessageImage.hidden = true
    }
    
    func addChatBubble(data: ChatBubbleData) {
        
        let padding:CGFloat = lastMessageType == data.type ? internalPadding/3.0 :  internalPadding
        let chatBubble = ChatBubble(data: data, startY:lastChatBubbleY + padding)
        self.scrollView.addSubview(chatBubble)
        
        lastChatBubbleY = CGRectGetMaxY(chatBubble.frame)
        
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), lastChatBubbleY + internalPadding)
        self.moveToLastMessage()
        lastMessageType = data.type
        textField.text = ""
        sendButton.enabled = false
    }
    
    func moveToLastMessage() {
        
        if scrollView.contentSize.height > CGRectGetHeight(scrollView.frame) {
            let contentOffSet = CGPointMake(0.0, scrollView.contentSize.height - CGRectGetHeight(scrollView.frame))
            self.scrollView.setContentOffset(contentOffSet, animated: true)
        }
    }
    
    func getRandomChatDataType() -> BubbleDataType {
        return BubbleDataType(rawValue: Int(arc4random() % 2))!
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Send button clicked
        textField.resignFirstResponder()
        self.addRandomTypeChatBubble()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var text: String
        
        if string.characters.count > 0 {
            text = String(format:"%@%@",textField.text!, string);
        } else {
            var string = textField.text! as NSString
            text = string.substringToIndex(string.length - 1) as String
        }
        if text.characters.count > 0 {
            sendButton.enabled = true
        } else {
            sendButton.enabled = false
        }
        return true
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
