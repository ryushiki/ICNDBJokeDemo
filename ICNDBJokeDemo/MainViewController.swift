//
//  ViewController.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 16/10/2.
//  Copyright © 2016年 liuzhihui. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var tableViewItems = [Joke]()
    
    var mainModel: MainModel?
    
    func handleRefresh(sender:AnyObject) {
        mainModel?.getJokeRandom()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UINib.init(nibName: Constant.JOKE_TABLE_VIEW_CELL_NIB_NAME, bundle: nil), forCellReuseIdentifier: Constant.JOKE_TABLE_VIEW_CELL_ID)
        
        let refreshControl = UIRefreshControl.init()
        refreshControl.tintColor = UIColor.blue
        refreshControl.addTarget(self, action: #selector(MainViewController.handleRefresh(sender:)), for: .valueChanged)
        self.refreshControl = refreshControl
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainModel = MainModel.init()
        mainModel?.getJokeRandom()
        mainModel?.addObserver(self, forKeyPath: Constant.MAIN_MODEL_JOKES_KEY_PATH, options: [.new, .old], context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainModel?.removeObserver(self, forKeyPath: Constant.MAIN_MODEL_JOKES_KEY_PATH)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let items = object as? MainModel {
            tableViewItems = items.jokes + tableViewItems
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.JOKE_TABLE_VIEW_CELL_ID
            , for: indexPath) as! JokeTableViewCell
        
        cell.jokeContent.text = tableViewItems[indexPath.row].jokeContent
        cell.updateDate.text = tableViewItems[indexPath.row].updateDate
        
        return cell
    }
    

}

