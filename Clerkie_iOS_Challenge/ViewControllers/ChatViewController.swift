//
//  ChatViewController.swift
//  Clerkie_iOS_Challenge
//
//  Created by Vishwas Mukund on 8/21/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation
import UIKit


class ChatViewController : UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBAction func segment(_ sender: Any) {
        
    let selection = segment.selectedSegmentIndex;
        print(selection);
        
        if(selection == 0){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
            let ChatViewController = storyBoard.instantiateViewController(withIdentifier: "chatViewController") as! UIViewController
            self.present(ChatViewController , animated:true, completion:nil)
            
        }else if(selection == 1){
            segment.selectedSegmentIndex = 1;
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
            let DashboardViewController = storyBoard.instantiateViewController(withIdentifier: "dashboardViewController") as! UIViewController
            self.present(DashboardViewController , animated:true, completion:nil)
        }
        
        
    }
    
    
        
    
    
    
       
        
        
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    
    
    
}
