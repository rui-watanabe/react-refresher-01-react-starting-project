//
//  ListViewController.swift
//  Tinder
//
//  Created by watar on 2019/09/23.
//  Copyright © 2019 rui watanabe. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var likedName = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

    }
    
//    //セルの数を幾つにしますか
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedName.count
    }

//    //セルの中身を表現していく
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //セルを作成するという指示
//        //withIdentifierはcellの名前
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        //likednameの中身で、cellの０番目にはlikednameの０番目が入りcellのい１番目にはlikednameの一番目が入る
        cell.textLabel?.text = likedName[indexPath.row]
        return cell
    }

}
