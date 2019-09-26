//
//  ViewController.swift
//  Swift5TableViewBasic
//
//  Created by watar on 2019/09/25.
//  Copyright © 2019 rui watanabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate  {
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var textArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource  = self
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
    return textArray.count
   }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    
    cell.selectionStyle = .none
    
    cell.textLabel?.text = textArray[indexPath.row]
    
    cell.imageView!.image = UIImage(named: "checkImage")
       
     return cell
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
  //タップした時にその配列の番号の中身を取り出して、値を渡す
    let nextVC = storyboard?.instantiateViewController(identifier: "next") as! NextViewController
        
        nextVC.toDoString = textArray[indexPath.row]
    
        navigationController?.pushViewController(nextVC, animated: true)
    
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height/6
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textArray.append(textField.text!)
        textField.resignFirstResponder()
        textField.text = ""
        tableView.reloadData()
        
        return true
    }

}

