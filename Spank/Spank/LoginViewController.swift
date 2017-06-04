//
//  LoginViewController.swift
//  Spank
//
//  Created by Madushani Lekam Wasam Liyanage on 6/3/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var facebookEmailTextField: UITextField!
    
    @IBOutlet weak var facebookPasswordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tbvc = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
        if FIRAuth.auth()?.currentUser != nil {
            
            self.present(tbvc, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func facebookLoginTapped(_ sender: UIButton) {
        if let email = facebookEmailTextField.text, let password = facebookPasswordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    print("User Login Error \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Failed!", message: "Failed to Login. Please Check Your Email and Password!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    
                    // self.clearTextFields()
                }
                else {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tbvc = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
                    
                    let alertController = UIAlertController(title: "Login Successful!", message: nil, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        self.present(tbvc, animated: true, completion: nil)
                        
                        // performSegue(withIdentifier: "mainTabSegue", sender: nil)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            
        }
        
        
    }
    
    @IBAction func facebookRegisterTapped(_ sender: UIButton) {
        
        if let email = facebookEmailTextField.text, let password = facebookPasswordTextField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    print("User Creating Error \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Signup Failed!", message: "Failed to Register. Please Try Again!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    
                    //self.clearTextFields()
                }
                else {
                    
                    let alertController = UIAlertController(title: "Signup Successful!", message: "Successfully Registered. Please Login to Use Our App!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    
                    //  let postDict = ["name": name, "email": email, "borough": borough] as [String:Any]
                    //
                    //                    let currentUser = FIRAuth.auth()?.currentUser?.uid
                    //                    self.databaseRef.child("users").child(currentUser!).setValue(postDict)
                    //                    self.present(alertController, animated: true, completion: nil)
                    //  self.clearTextFields()
                }
            })
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
