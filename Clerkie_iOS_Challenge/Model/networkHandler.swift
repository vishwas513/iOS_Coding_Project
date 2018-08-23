//
//  networkHandler.swift
//  Clerkie_iOS_Challenge
//
//  Created by Vishwas Mukund on 8/20/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation

class networkHandler {
    func getLogin(userName:String,password:String, completionHandler: @escaping (_ loginStatus: Bool) -> ()){
        //https://api.mlab.com/api/1/databases/application_data/collections/Users?q={"userName": "admin"}&apiKey=NOGVone7rgDPU_YxPvDFgqgeYiGQlTxs
      //  let url = NSURL(string: constants().baseUrl + "/" + constants().loginCollection + "collections/Users?q={" + \"userName",\ + ":" + userName as! String);!
     
        let urlString:String = constants().baseUrl + constants().loginCollection + "?q=" + "{\"userName\":\"" + userName + "\",\"password\"" + password + "\"}&apiKey=" + constants().apiKey;
        let url2 = "https://api.mlab.com/api/1/databases/application_da"
        
        let urlLogin = URL(string: url2);
        print(urlString,urlLogin);
        
        //Creating the Request Object with options
        let request = NSMutableURLRequest(url: urlLogin as! URL)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        // Asynchronously perform GET operation
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            
            // Parse into json and then convert into dictionary
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            if(json != nil){
                let response = json as! NSDictionary
                //Send data back to calling function
                completionHandler(true);
            }else {
                let tempDict = NSDictionary();
                //Send Empty NSDictionary to calling function
                completionHandler(false);
            }
        }
        task.resume();
    }
}
