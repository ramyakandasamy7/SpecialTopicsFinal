//
//  SignUpViewController.swift
//  SpecialTopicsProject
//
//  Created by Ramya Kandasamy on 12/2/20.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailADdress: UITextField!
    
    @IBOutlet weak var error: UILabel!
    //check the fields and validate that the data is correct, if everything is correct, this method returns nil, otherwise it returns the error message
    func validateFields() -> String? {
        //Check that all fields are filled in
        if (firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailADdress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return " Please fill in the correct fields"
        }
        return nil
    }
    func transitiontoHome() {
        let homeViewController = self.storyboard?.instantiateViewController(identifier: constants.Storyboard.forumViewController) as? FormViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    @IBAction func signUp(_ sender: Any) {
        //validate the fields
        //create the user
        //transition to home screen
        let error = validateFields()
        if error != nil {
            showError(message: error!)
           
        }
        else {
            let dbfirstName = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dblastName = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dbemail = emailADdress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dbpassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: dbemail, password: dbpassword) { (result, err) in
                if err != nil {
                    self.showError(message: "error creating user")
                }
                else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":dbfirstName, "lastname":dblastName]) { (error) in
                        if error != nil {
                            self.showError(message: "saving user data")
                        }
                    }
                    self.transitiontoHome()
                    //Transition to home screen
                }
                
            }
        }
        
    }
    func showError (message:String) {
        error.text = message
        error.alpha = 1
    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
