//
//  DetailViewController.swift
//  President
//
//  Created by Sergio A. Balderas on 06/07/17.
//  Copyright © 2017 Sergio A. Balderas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var webView: UIWebView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func configureView() {
    if let detail = self.detailItem {
      if let label = self.detailDescriptionLabel {
//        label.text = detail.description
        let dict = detail as! [String: String]
        let urlString = dict["url"]!
        label.text = urlString
        
        let url = NSURL(string: urlString)!
        let request = URLRequest(url: url as URL)
        webView.loadRequest(request)
        let name = dict["name"]!
        title = name
      }
    }
  }
  
  var detailItem: Any? {
    didSet {
      self.configureView()
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
