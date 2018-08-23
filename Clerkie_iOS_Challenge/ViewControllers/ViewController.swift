//
//  ViewController.swift
//  Clerkie_iOS_Challenge
//
//  Created by Vishwas Mukund on 8/20/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func submitButton(_ sender: Any) {
//        networkHandler().getLogin(userName: "admin", password: "admin") { (results) in
//            print(results);
//        }
        
        // unwraps the textfields and stores them in constants
        guard let email = userName.text, let password = password.text else {
            showAlert(title: "Error", message: "Please enter an email and password")
            return
        }
        // check to make sure they are not an empty string
        guard email != "", password != "" else {
            showAlert(title: "Error", message: "Please enter an email and password")
            return
        }
        
        AuthService.instance.emailLogin(email, password: password) { (success, message) in
            if success {
                self.setUsername()
               // self.performSegue(withIdentifier: "showMainVC", sender: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
                let ChatViewController = storyBoard.instantiateViewController(withIdentifier: "chatViewController") as! UIViewController
                self.present(ChatViewController , animated:true, completion:nil)
            } else {
                
                self.showAlert(title: "Failure", message: message)
            }
        }
        
        
        
       
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setUsername()
        if AuthService.instance.isLoggedIn {
           
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
            let ChatViewController = storyBoard.instantiateViewController(withIdentifier: "chatViewController") as! UIViewController
            self.present(ChatViewController , animated:true, completion:nil)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUsername() {
        if let user = Auth.auth().currentUser {
            AuthService.instance.isLoggedIn = true
            let emailComponents = user.email?.components(separatedBy: "@")
            if let username = emailComponents?[0] {
                AuthService.instance.username = username
            }
        } else {
            AuthService.instance.isLoggedIn = false
            AuthService.instance.username = nil
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }


}

