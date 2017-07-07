//
//  MasterViewController.swift
//  President
//
//  Created by Sergio A. Balderas on 06/07/17.
//  Copyright © 2017 Sergio A. Balderas. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
      
//      self.navigationItem.leftBarButtonItem = self.editButtonItem
//      let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(inProcess))
//      self.navigationItem.rightBarButtonItem = addButton
//      if let split = self.splitViewController {
//        let controllers = split.viewControllers
//        self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
      
      let path = Bundle.main.path(forResource: "PresidentList", ofType: "plist")
      let presidentInfo = NSDictionary(contentsOfFile: path!)!
      presidents = presidentInfo["presidents"]! as! [[String: String]]
      
      if let split = self.splitViewController {
        let controllers = split.viewControllers
        self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  // Variables
  var detailViewController: DetailViewController? = nil
//  var objects = [Any]()
  var presidents: [[String: String]]!

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presidents.count
    }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let president = presidents[indexPath.row]
    cell.textLabel!.text = president["name"]
    return cell
  }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let object = presidents[indexPath.row]
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        if let oldController = detailViewController {
          controller.languageString = oldController.languageString
        }
        controller.detailItem = object
        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
        detailViewController = controller
      }
    }
  }

}
