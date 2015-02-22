//
//  ViewController.swift
//  HitList
//
//  Created by Joshua Adams on 2/22/15.
//  This project is adapted from the excellent tutorial "Your First Core Data App Using Swift" by Pietro Rea.
//

// Note: One of the two fixes suggested http://stackoverflow.com/questions/25076276/unable-to-find-specific-subclass-of-nsmanagedobject must be used for this app to run. Without one of the fixes, the warning described in that question is issued. I used the solution of prepending the project name to the entity class name, but I found that the @objc(Person) solution also works.

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let managedContext = CDManager.sharedCDManager.context
        let fetchRequest = NSFetchRequest(entityName:"Person")
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        if let results = fetchedResults {
            people = results as [Person]
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
    }
    
    @IBAction func addName(sender: UIBarButtonItem) {
        var alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.saveName(textField.text)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    func saveName(name: String) {
        let managedContext = CDManager.sharedCDManager.context
        let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let person = Person(entity: entity!, insertIntoManagedObjectContext: managedContext)
        person.name = name
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        people.append(person)
    }
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        let person = people[indexPath.row] as Person
        cell.textLabel!.text = person.name
        return cell
    }
}

