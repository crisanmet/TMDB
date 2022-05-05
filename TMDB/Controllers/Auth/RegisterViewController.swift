//
//  RegisterViewController.swift
//  TMDB
//
//  Created by Cristian Sancricca on 20/04/2022.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) {AuthResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                    print(e.localizedDescription)
                } else{
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
                    
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                }
            }
        }
    }
}
