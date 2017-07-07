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
  private var languageListController: LanguagueListController?
  private var languageButton: UIBarButtonItem?
//  var languageString = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.configureView()
      
      languageButton = UIBarButtonItem(title: "Choose language", style: .plain, target: self, action: #selector(DetailViewController.showLanguagePopover))
      navigationItem.rightBarButtonItem = languageButton
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
//        let urlString = dict["url"]!
        let urlString = modifyurlForlanguage(url: dict["url"]!, language: languageString)
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
  
  private func modifyurlForlanguage(url: String, language lang: String?) -> String {
    var newUrl = url
    
    if let langStr = lang {
      let range = NSMakeRange(8, 2)
      if !langStr.isEmpty && (url as NSString).substring(with: range) != langStr {
        newUrl = (url as NSString).replacingCharacters(in: range, with: langStr)
      }
    }
    
    return newUrl
  }
  
  var languageString = "" {
    didSet {
      if languageString != oldValue {
        configureView()
      }
    }
  }
  
  func showLanguagePopover() {
    if languageListController == nil {
      languageListController = LanguagueListController()
      languageListController!.detailViewController = self
      languageListController!.modalPresentationStyle = .popover
    }
    present(languageListController!, animated: true, completion: nil)
    if let ppc = languageListController?.popoverPresentationController {
      ppc.barButtonItem = languageButton
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
