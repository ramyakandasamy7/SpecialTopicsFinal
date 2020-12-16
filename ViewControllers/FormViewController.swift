//
//  FormViewController.swift
//  SpecialTopicsProject
//
//  Created by Ramya Kandasamy on 12/3/20.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

struct Posts {
    let words: String
    let username: String
}

class FormViewController: UITableViewController {
 
    var entries = [Posts]()
    let database = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
func getData() {
   print("I am in get Data")
    self.database.collection("posts").getDocuments { (snapshot, err) in
           if let err = err {
               print("Error getting documents: \(err)")
           } else {
               for document in snapshot!.documents {
                  let  words = document.get("words") as! String
                  let username = document.get("username") as! String
                let post = Posts(words: words,username: username)
                self.entries.append(post)
               }
           }
        print(self.entries)
    self.tableView.reloadData()
}
}

    // MARK: - Table view data source
override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.entries.count + 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell", for:indexPath) 
            return cell
        }
        else {
            for x in entries {
                print ("PRINTING ENTRIES \(x.username) \(x.words)")
            }
        
          let cell = tableView.dequeueReusableCell(withIdentifier: "ForumPosts", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            let indexT = indexPath.row - 1
            cell.textLabel?.text =  self.entries[indexT].words + "\n" + self.entries[indexT].username
            //cell.texttopresent.text = self.entries[indexT].words
        return cell
        }
      }

      override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Positive Posts Only"
        }
        else {
        return "Section \(section)"
        }
      }
    
 

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
