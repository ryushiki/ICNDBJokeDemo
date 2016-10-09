//
//  ViewController.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 16/10/9.
//  Copyright © 2016年 liuzhihui. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var mainModel: MainModel?
    
    var fetchedResultsController: NSFetchedResultsController<FunnyJoke>? {
        let fetchRequest =  NSFetchRequest<FunnyJoke>(entityName: "FunnyJoke")
        let sortDescriptor = NSSortDescriptor(key: "updateDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoredataUtil.sharedInstance.mainContext!,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
    }
    
    
    func handleRefresh(sender: AnyObject) {
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
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("An perform fetch error has occured")
        }
        
        mainModel = MainModel.init()
        mainModel?.getJokeRandom()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController?.sections {
            return sections.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.JOKE_TABLE_VIEW_CELL_ID,
            for: indexPath) as! JokeTableViewCell
        let joke = fetchedResultsController?.object(at: indexPath)
        
        cell.jokeContent.text = joke?.jokeContent
        cell.updateDate.text = joke?.updateDate
        
        return cell
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
    
}

