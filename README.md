# Hello, this is a ToDo List App that is written in Swift and uses CloudKit.

----
## What is CloudKit?
See [Cloud Kit Framework Reference](https://developer.apple.com/library/prerelease/ios/documentation/CloudKit/Reference/CloudKit_Framework_Reference/index.html)

> The Cloud Kit framework provides interfaces for moving data between your app and your iCloud containers. You use Cloud Kit to take your app’s existing data and store it in the cloud so that the user can access it on multiple devices. You can also store data in a public area where all users can access it.

----
## Usage
1. Go to General and sign your application.
2. Go to Capabilities and add iCloud + CloudKit to your application.
3. Make sure that you have an iCloud account active in your simulator.

Disclaimer: Please not that this is simply a side project I worked on while at WWDC. Written in around 3 hours after announcement while Swift was still fairly new to everyone. While things might not be perfect, they work and I will update the repo accordingly as I learn more about Swift and CloudKit. 

----
## Quick Reference

> Fetch all tasks
    
    loadTasks()

> Delete all tasks
    
    deleteTasks() 

> Add a task with a priority
   
    recordSaved()


----
## Contact
[Twitter](https://twitter.com/asg) - Follow me on Twitter.

## License

[MIT License](http://opensource.org/licenses/MIT) - Fork, modify and use however you want.
