//
//  PostViewController.swift
//  SpecialTopicsProject
//
//  Created by Ramya Kandasamy on 12/3/20.
//

import UIKit
import NaturalLanguage
import Firebase

class PostViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    let db = Firestore.firestore()
    @IBAction func submitforPosting(_ sender: Any) {
        if let label = sentimentClassifier?.predictedLabel(for: self.textEntry.text) {
            switch label {
            case "insult":
                //self.resultImage.image = UIImage(named: "positive")
                self.resultLabel.text = "You have written an insult, you can not post this text"
            case "notaninsult":
               // self.resultImage.image = UIImage(named: "negative")
                self.posttoDB()
            default:
               // self.resultImage.image = UIImage(named: "neutral")
                self.resultLabel.text = "Neutral"
            }
        }
    }
    private lazy var sentimentClassifier: NLModel? = {
        let model = try? NLModel(mlModel: insultclassifier_1().model)
        return model
    }()
    @IBOutlet weak var textEntry: UITextView!
    
    @IBAction func clearText(_ sender: Any) {
        self.textEntry.text = ""
    }
    func posttoDB(){
        let user = Auth.auth().currentUser
        db.collection("posts").addDocument(data: ["words" : self.textEntry.text, "username": user?.email])
        let homeViewController = storyboard?.instantiateViewController(identifier: constants.Storyboard.forumViewController) as? FormViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
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
