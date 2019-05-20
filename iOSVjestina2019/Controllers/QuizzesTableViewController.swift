//
//  QuizzesTableViewController.swift
//  iOSVjestina2019
//
//  Created by FIVE on 02/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class QuizzesTableViewController: UITableViewController {

    var sections: [Category]?
    var groupedQuizzes: Dictionary<Category, [Quiz]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchQuizzes()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let sections = self.sections {
            print("Sekcije ", sections.count)
            return sections.count
        }
        print("Sekcije 0")
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let groupedQuizzes = self.groupedQuizzes {
            return (groupedQuizzes[self.sections![section]]?.count)!
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let cell = QuizTableViewCell()
        cell.titleLabel?.text = "Title"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    func fetchQuizzes(/*completionHandler: @escaping () -> Void*/) {
        let quizService = QuizService()

        quizService.fetchQuizzes { (quizzes) in
            if let quizzes = quizzes {
                self.groupedQuizzes = Dictionary(grouping: quizzes) { quiz in quiz.category }
                
                if let keys = self.groupedQuizzes?.keys {
                    self.sections = Array(keys)
                }
//                    quizService.fetchImage(urlString: quiz.imageURL, completion: { (image) in
//                        DispatchQueue.main.async {
//                            self.pictureImageView.image = image
//                            self.pictureImageView.center.x = self.view.center.x
//                        }
//                    })
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }

}
