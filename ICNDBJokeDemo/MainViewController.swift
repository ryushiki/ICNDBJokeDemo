//
//  ViewController.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 16/10/2.
//  Copyright © 2016年 liuzhihui. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UINib.init(nibName: Constant.JOKE_TABLE_VIEW_CELL_NIB_NAME, bundle: nil), forCellReuseIdentifier: Constant.JOKE_TABLE_VIEW_CELL_ID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }
    
    

}

