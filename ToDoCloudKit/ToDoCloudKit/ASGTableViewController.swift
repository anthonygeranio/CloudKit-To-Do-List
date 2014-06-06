//
//  ASGTableViewController.swift
//  ToDoCloudKit
//
//  Created by Anthony Geranio on 6/4/14.
//  Copyright (c) 2014 Anthony Geranio. All rights reserved.
//

import UIKit
import CloudKit
import Foundation

class ASGTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
 
// Create the UITableView to retreive the data into
@IBOutlet var tasksTable : UITableView = nil
// Crete an array to store the tasks
var tasks: NSMutableArray = NSMutableArray()
// Create a CKRecord for the items in our database we will be retreiving and storing
var items: CKRecord[] = []
    
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
        }
        
        println("End fetch")

        // Print items array contents
        println(items)

        // Add contents of the item array to the tasks array
        tasks.addObjectsFromArray(items)

        // Reload the UITableView with the retreived contents
        tasksTable.reloadData()
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
    }
        
    println("End fetch")

    // Print items array contents
    println(items)

    // Iterate through the array content ids
    var ids : CKRecordID[] = []
    for i in items {
        ids.append(i.recordID)
    }
        
    // Create the database where you will delete your data from
    var database: CKDatabase = CKContainer.defaultContainer().privateCloudDatabase
        
    // Delete the data from the database using the ids we iterated through
    var clear: CKModifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: ids)
    database.addOperation(clear)
    
    // Reload the UITableView and retreive the new contents
    tasksTable.reloadData()
    
    }
   
    queryOperation.queryCompletionBlock = fetchFinished
    
    // Create the database where you will retreive your new data from
    var database: CKDatabase = CKContainer.defaultContainer().privateCloudDatabase
    database.addOperation(queryOperation) 
}
    
override func viewDidAppear(animated: Bool)  {
    super.viewDidAppear(animated)

    loadTasks()
    tasksTable.reloadData()
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    tasksTable.delegate = self
    tasksTable.dataSource = self
    
    // Create an add button that helps you create a new task
    var addButton: UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showNewTaskViewController"))
    // Create a delete button that helps you delete all items in your database for a particular record
    var deleteButton: UIBarButtonItem = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Plain, target: self, action:Selector("deleteTasks"))
   
    // Set the navigationItem title
    navigationItem.title = "To Do List"
    // Set the add button on the right side of the UINavigationBar
    navigationItem.rightBarButtonItem = addButton
    // Set the delete button on the left side of the UINavigationBar
    navigationItem.leftBarButtonItem = deleteButton
    
    tasksTable.reloadData()
}

// Function to switch to the new task view    
func showNewTaskViewController() {
    var newTaskVC: ASGNewTaskViewController = ASGNewTaskViewController()
    newTaskVC.todoVC = self
    navigationController.pushViewController(newTaskVC, animated: true)
}
    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
    
override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
    // Return the number of sections.
    return 1
}
    
override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    return tasks.count
}
    
    
override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
    let cellIdentifier = "taskCell"
    
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
    println(tasks)
    var task: CKRecord = tasks[indexPath.row] as CKRecord
    
    // Set the main cell label for the key we retreived: taskKey. This can be optional.
    if let text = task.objectForKey("taskKey") as? String {
        cell.text = text
    }

    // Set the detail cell label for the key we retreived: priorityKey. This can be optional.
    if let detail = task.objectForKey("priorityKey") as? String {
        cell.detailTextLabel.text = detail
    }
    
    return cell as UITableViewCell
    
}
    
override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    
    // Deselect the row using an animation.
    tasksTable.deselectRowAtIndexPath(indexPath, animated: true)
    
    // Reload the row using an animation.
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)

    // TODO: Implement done
    
}

}
