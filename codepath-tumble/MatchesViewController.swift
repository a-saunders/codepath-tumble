//
//  MatchesViewController.swift
//  codepath-tumble
//
//  Created by Alexandra Saunders on 6/22/16.
//  Copyright © 2016 red58 Communications. All rights reserved.
//

import UIKit

class MatchesViewController: UIViewController {

    @IBOutlet weak var scroll1View: UIScrollView!
    
    @IBOutlet weak var scroll2View: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll1View.contentSize = CGSize(width: 320, height: 660)
        scroll2View.contentSize = CGSize(width: 360, height: 100)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
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
