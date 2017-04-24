//
//  ViewController.swift
//  taskapp
//
//  Created by 藤田 和樹 on 2017/04/20.
//  Copyright © 2017年 藤田 和樹. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    let taskArray = try! Realm().objects(Task.self).sorted(byProperty: "date", ascending: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return taskArray.count
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPathas as IndexPath)
        
        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
         let dateString:String = formatter.string(from: task.date as Date)
        cell.detailTextLabel?.text = dateString
        
       return cell
}
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     performSegue(withIdentifier: "cellSegue",sender: nil)
    
}
 func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCellEditingStyle {
    return UITableViewCellEditingStyle.delete
}
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            try! realm.write {
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
            }
            override func prepare(for segue: UIStoryboardSegue, sender: Any?){
                 let inputViewController:InputViewController = segue.destination as! InputViewController
                
                 if segue.identifier == "cellSegue" {
                    let indexPath = self.tableView.indexPathForSelectedRow
                    inputViewController.task = taskArray[indexPath!.row]
                 } else {
                    let task = Task()
                    task.date = NSDate()
                    
                    if taskArray.count != 0 {
                        task.id = taskArray.max(ofProperty: "id")! + 1
                    }
                     inputViewController.task = task
                }
             }
}
}
