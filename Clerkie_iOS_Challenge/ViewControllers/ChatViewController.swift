//
//  ChatViewController.swift
//  Clerkie_iOS_Challenge
//
//  Created by Vishwas Mukund on 8/21/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth






extension ChatViewController: DataServiceDelegate {
    func dataLoaded() {
        tableView.reloadData()
        if DataService.instance.messages.count > 0 {
            let indexPath = IndexPath(row: DataService.instance.messages.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let msg = DataService.instance.messages[(indexPath as NSIndexPath).row]
        print("msg",msg);
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell {
            if let user = msg.userId, let message = msg.message {
                cell.configureCell(user: user, message: message)
            }
            return cell
        } else {
            return MessageCell()
        }
    }
}

class ChatViewController : UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var messageTextField: UITextField!
    
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
    @IBOutlet weak var tableView: UITableView!
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil);
            let LoginViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! UIViewController
            self.present(LoginViewController , animated:true, completion:nil)
        } catch {
            print("An error occurred signing out")
        }
    
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let messageText = messageTextField.text else {
            LoginController().showAlert(title: "Error", message: "Please enter a message")
            return
        }
        guard messageText != "" else {
            LoginController().showAlert(title: "Error", message: "No message to send")
            return
        }
        if let user = AuthService.instance.username {
            DataService.instance.saveMessage(user, message: messageText)
            messageTextField.text = ""
            dismissKeyboard()
            tableView.reloadData()
        }
    

    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.instance.delegate = self
        
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action:
            #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        
        
    }
    
    @objc func keyboardWillShow(notif: NSNotification) {
        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notif: NSNotification) {
        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
