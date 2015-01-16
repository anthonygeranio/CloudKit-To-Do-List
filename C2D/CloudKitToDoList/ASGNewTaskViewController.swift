//
//  ASGNewTaskViewController.swift
//  CloudKitToDoList
//
//  Created by Anthony Geranio on 1/15/15.
//  Copyright (c) 2015 Sleep Free. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class ASGNewTaskViewController: UIViewController, UITableViewDelegate, UITextViewDelegate {

    // UITextView for task description.
    @IBOutlet var taskDescriptionTextView: UITextView!
    
    // Function to add a task to the iCloud database
    func addTask() {
        
        navigationController?.popViewControllerAnimated(true)
        
        // Create record to save tasks
        var record: CKRecord = CKRecord(recordType: "task")
        // Save task description for key: taskKey
        record.setObject(self.taskDescriptionTextView.text, forKey: "taskKey")
        // Create the private database for the user to save their data to
        var database: CKDatabase = CKContainer.defaultContainer().privateCloudDatabase
        
        // Save the data to the database for the record: task
        func recordSaved(record: CKRecord?, error: NSError?) {
            if (error != nil) {
                // handle it
                println(error)
            }
        }
        
        // Save data to the database for the record: task
        database.saveRecord(record, completionHandler: recordSaved)
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        // Create done button to add a task
        var doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addTask"))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
}
