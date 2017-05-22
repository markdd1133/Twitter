//
//  RegisterVC.swift
//  Twitter
//
//  Created by Sheng Chi Chen on 2017/5/15.
//  Copyright © 2017年 Sheng Chi Chen. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func register(_ sender: Any) {
        //if no text
        if username.text!.isEmpty || password.text!.isEmpty || email.text!.isEmpty || firstname.text!.isEmpty || lastname.text!.isEmpty{
            //red placeholders
            username.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName:UIColor.red])
            password.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:UIColor.red])
            email.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName:UIColor.red])
            firstname.attributedPlaceholder = NSAttributedString(string: "firstname", attributes: [NSForegroundColorAttributeName:UIColor.red])
            lastname.attributedPlaceholder = NSAttributedString(string: "lastname", attributes: [NSForegroundColorAttributeName:UIColor.red])
        //if text is entered
        }else{
            //create new user in MySQL
            
            //url to php file
            let url = NSURL(string: "http://localhost/Twitter/register.php")
            
            //request to this file
            let request = NSMutableURLRequest(url: url as! URL)
            
            //method to pass data to this file(e.g. via POST)
            request.httpMethod = "POST"
            
            //body to be appended to url
            let body = "username=\(username.text!.lowercased())&password=\(password.text!)&email=\(email.text!)&fullname=\(firstname.text!)%20\(lastname.text!)"
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            //proceed request
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                
                if error == nil {
                    
                    // get main queue in code process to communicate back to UI
                    DispatchQueue.main.async(execute: {
                        
                        do {
                            // get json result
                            let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                            
                            // assign json to new var parseJSON in guard/secured way
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                return
                            }
                            
                            //get id from parseJSON dictionary
                            let id = parseJSON["id"]
                            
                            //if there is some id value
                            if id != nil{
                                print(parseJSON)
                            }
                        }catch{
                            print("Caught an error: \(error)")
                        }
                    })
            }else{
                print("error: \(error?.localizedDescription)")
            }
        //launching
        }).resume()
        }
    }
    
    

}

