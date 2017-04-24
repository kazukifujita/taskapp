//
//  InputViewController.swift
//  taskapp
//
//  Created by 藤田 和樹 on 2017/04/24.
//  Copyright © 2017年 藤田 和樹. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
   
    let realm = try! Realm()
    var task: Task!
  
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = task.title
        contentsTextView.text = task.contents
        datePicker.date = task.date as Date
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.


    }
    
override func viewWillDisappear(_ animated: Bool) {
    try! realm.write {
        self.task.title = self.titleTextField.text!
        self.task.contents = self.contentsTextView.text
        self.task.date = self.datePicker.date as NSDate
        self.realm.add(self.task, update: true)
    }
        super.viewWillDisappear(animated)
}
    func dismissKeyboard(){
        
        view.endEditing(true)
}


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
