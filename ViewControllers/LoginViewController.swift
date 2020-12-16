//
//  LoginViewController.swift
//  SpecialTopicsProject
//
//  Created by Ramya Kandasamy on 12/2/20.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var emailaddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func transitiontoHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: constants.Storyboard.forumViewController) as? FormViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let email = emailaddress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passworddb = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        print("email is" + email)
        print("password is" + passworddb)
        Auth.auth().signIn(withEmail: email, password: passworddb) { (result, err) in
            if err != nil {
                self.errorLabel.text = err?.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                self.transitiontoHome()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
