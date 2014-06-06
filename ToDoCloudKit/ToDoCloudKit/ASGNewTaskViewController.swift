//
//  ASGNewTaskViewController.swift
//  ToDoCloudKit
//
//  Created by Anthony Geranio on 6/4/14.
//  Copyright (c) 2014 Anthony Geranio. All rights reserved.
//

import UIKit
import CloudKit

class ASGNewTaskViewController: UIViewController {
    
// UITextField for task description.
@IBOutlet var taskDescriptionTextField : UITextField
// UILabel for priority. Can either be 'Important' or 'Not Important'.
@IBOutlet var priorityLabel: UILabel
// UISwitch for priority. Can be either 'Off' or 'On'. This also changes the priority label accordingly.
@IBOutlet var flagButton: UISwitch
    
var todoVC: ASGTableViewController = ASGTableViewController()
    
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
}
    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
    
// Create the button to add the task
@IBAction func addTaskButtonPressed(sender : AnyObject) {
    
    navigationController.popViewControllerAnimated(true)
    
    // Create record to save tasks
    var record: CKRecord = CKRecord(recordType: "task")
    // Save task description for key: taskKey
    record.setObject(self.taskDescriptionTextField.text, forKey: "taskKey")
    // Save priority for key: priorityKey
    record.setObject(self.priorityLabel.text, forKey: "priorityKey")
    // Create the private database for the user to save their data to
    var database: CKDatabase = CKContainer.defaultContainer().privateCloudDatabase
    
    // Save the data to the database for the record: task
    func recordSaved(record: CKRecord?, error: NSError?) {
        if error {
            // handle it
            println(error)
        }
    }
    
    // Save data to the database for the record: task
    database.saveRecord(record, completionHandler: recordSaved) }
    
// Create the button to set the priority
@IBAction func addFlagButtonPressed(sender: AnyObject) {
    
    // Detect wether the UISwitch is on or off
    if(flagButton.on) {
        priorityLabel.text = "Important"
    } else {
        priorityLabel.text = "Not Important"
    }
}
    
}
