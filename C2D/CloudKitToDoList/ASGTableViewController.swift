//
//  ASGTableViewController.swift
//  CloudKitToDoList
//
//  Created by Anthony Geranio on 1/15/15.
//  Copyright (c) 2015 Sleep Free. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class ASGTableViewController: UITableViewController, UITableViewDelegate {
    
    // Crete an array to store the tasks
    var tasks: NSMutableArray = NSMutableArray()
    // Create a CKRecord for the items in our database we will be retreiving and storing
    var items: [CKRecord] = []
    
    // Function to load all tasks in the UITableView and database
    func loadTasks() {
        
        // Create the query to load the tasks
        var query = CKQuery(recordType: "task", predicate: NSPredicate(format: "TRUEPREDICATE"))
        var queryOperation = CKQueryOperation(query: query)
        
        println("Start fetch")
        
        // Fetch the items for the record
        func fetched(record: CKRecord!) {
            items.append(record)
        }
        
        queryOperation.recordFetchedBlock = fetched
        
        // Finish fetching the items for the record
        func fetchFinished(cursor: CKQueryCursor?, error: NSError?) {
            
            if error != nil {
                println(error)
            } else {
                println("End fetch")
            }
            
            // Print items array contents
            println(items)
            
            // Add contents of the item array to the tasks array
            tasks.addObjectsFromArray(items)
            
            // Reload the UITableView with the retreived contents
            self.tableView?.reloadData()
        }
        
        
        queryOperation.queryCompletionBlock = fetchFinished
        
        // Create the database you will retreive information from
        var database: CKDatabase = CKContainer.defaultContainer().privateCloudDatabase
        database.addOperation(queryOperation)
        
    }
    
    // Function to delete all tasks in the UITableView and database
    func deleteTasks() {
        
        // Create the query to load the tasks
        var query = CKQuery(recordType: "task", predicate: NSPredicate(format: "TRUEPREDICATE"))
        var queryOperation = CKQueryOperation(query: query)
        println("Begin deleting tasks")
        
        // Fetch the items for the record
        func fetched(record: CKRecord!) {
            items.append(record)
        }
        
        queryOperation.recordFetchedBlock = fetched
        
        
        // Finish fetching the items for the record
        func fetchFinished(cursor: CKQueryCursor?, error: NSError?) {
            
            if error != nil {
                println(error)
            }
            
            println("All tasks have been deleted")
            
            // Print items array contents
            println(items)
            
            // Iterate through the array content ids
            var ids : [CKRecordID] = []
            for i in items {
                ids.append(i.recordID)
            }
            
            // Create the database where you will delete your data from
            var database: CKDatabase = CKContainer.defaultContainer().privateCloudDatabase
            
            // Reload the UITableView with the retreived contents
            self.tableView!.reloadData()
            
        }
        
        queryOperation.queryCompletionBlock = fetchFinished
        
        // Create the database where you will retreive your new data from
        var database: CKDatabase = CKContainer.defaultContainer().privateCloudDatabase
        database.addOperation(queryOperation)
    }
    
    // MARK: UITableView Delegate Methods
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return tasks.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        println(tasks)
        
        var task: CKRecord = tasks[indexPath.row] as CKRecord
        
        // Set the main cell label for the key we retreived: taskKey. This can be optional.
        if let text = task.objectForKey("taskKey") as? String {
            cell.textLabel?.text = text
        }

        return cell as UITableViewCell
        
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Deselect the row using an animation.
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Reload the row using an animation.
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        
    }
    
    // MARK: Lifecycle
    override func viewDidAppear(animated: Bool)  {
        super.viewDidAppear(animated)
        
        loadTasks()
        self.tableView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.reloadData()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Create delete button to delete all tasks
        var deleteButton: UIBarButtonItem = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("deleteTasks"))
        self.navigationItem.leftBarButtonItem = deleteButton
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
