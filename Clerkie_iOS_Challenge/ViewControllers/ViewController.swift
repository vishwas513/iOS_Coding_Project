//
//  ViewController.swift
//  Clerkie_iOS_Challenge
//
//  Created by Vishwas Mukund on 8/20/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func submitButton(_ sender: Any) {
      //  networkHandler().getLogin(userName: "admin", password: "admin") { (results) in
            
      //      print(results);
            
            
      //  }
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
        let ChatViewController = storyBoard.instantiateViewController(withIdentifier: "chatViewController") as! UIViewController
        self.present(ChatViewController , animated:true, completion:nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

