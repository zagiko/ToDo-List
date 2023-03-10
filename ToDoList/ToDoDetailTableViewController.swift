//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Mike on 05.11.2022.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
    
    var toDo: ToDos?
    
    var isDatePickeHidden = true
    let dateLabeleIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    
    @IBOutlet weak var toDoTitleTextField: UITextField!
    @IBOutlet weak var isConpleatedButton: UIButton!
    @IBOutlet weak var dueDateLable: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButtonState()
        updateDateInfo()
        loadOldData()
    }
    
    func saveButtonState() {
        if toDo == nil {
            let enableButton = toDoTitleTextField.text?.isEmpty == false
            saveButton.isEnabled = enableButton
        } else {
            saveButton.isEnabled = true
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickeHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
            
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return 216
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == dateLabeleIndexPath {
            isDatePickeHidden.toggle()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
    }
    
    @IBAction func textFiledAction(_ sender: UITextField) {
        saveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleatedButtonTapted(_ sender: UIButton) {
        isConpleatedButton.isSelected.toggle()
    }
    
    func updateDateInfo() {
        dueDatePicker.minimumDate = Date(timeInterval: 3*60*60, since: .now)
        dueDateLable.text = dueDatePicker.date.formatted(date: .abbreviated, time: .shortened)
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        updateDateInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "Save" else { return }
        
        let title = toDoTitleTextField.text!
        let isCompleate = isConpleatedButton.isSelected
        let date = dueDatePicker.date
        let notes = notesTextView.text
        
//        if toDo != nil {
//            toDo?.title = title
//            toDo?.isCompleated = isCompleate
//            toDo?.dueDate = dueDatePicker.date
//            toDo?.notes = notes
//        } else {
            toDo = ToDos(title: title, isCompleated: isCompleate, dueDate: date, notes: notes)
//        }
    }
    
    func loadOldData() {
        guard let toDo = toDo else { return }
        toDoTitleTextField.text = toDo.title
        isConpleatedButton.isSelected = toDo.isCompleated
        dueDatePicker.date = toDo.dueDate
        dueDateLable.text = toDo.dueDate.formatted(date: .abbreviated, time: .shortened)
        notesTextView.text = toDo.notes
    }
}
