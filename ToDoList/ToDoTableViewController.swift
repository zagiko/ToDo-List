//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Mike on 04.11.2022.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    func checkmarckTaped(sender: ToDoTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var toDo = toDos[indexPath.row]
            toDo.isCompleated.toggle()
            toDos[indexPath.row] = toDo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDos.saveToDos(toDos)
        }
        
    }
    
    
    var selectedRow: IndexPath? = nil
    
    var toDos = [ToDos]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let saveToDo = ToDos.loadToDos() {
            toDos = saveToDo
        } else {
            toDos = ToDos.loadSampleToDos()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom cell", for: indexPath) as! ToDoTableViewCell
        let temp = toDos[indexPath.row]
        //        var content = cell.defaultContentConfiguration()
        cell.delegate = self
        cell.titleLable?.text = temp.title
        cell.isCompleated.isSelected = temp.isCompleated
        
        //        content.text = temp.title
        //        content.secondaryText = temp.notes
        //
        //        cell.contentConfiguration = content
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            ToDos.saveToDos(toDos)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func closeWindow(segue: UIStoryboardSegue) {
        guard segue.identifier == "Save" else { return }
        let sourceVC = segue.source as! ToDoDetailTableViewController
        
        if let toDo = sourceVC.toDo {
            
            if selectedRow == nil {
                let tempData = IndexPath(row: toDos.count, section: 0)
                toDos.append(toDo)
                tableView.insertRows(at: [tempData], with: .automatic)
            } else {
                guard let element = selectedRow else { return }
                toDos[element.row] = toDo
                
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.reloadData()
            selectedRow =
            nil
        }
        ToDos.saveToDos(toDos)
    }
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        let detailControler = ToDoDetailTableViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return detailControler }
        
        tableView.deselectRow(at: indexPath, animated: true)
        detailControler?.toDo = toDos[indexPath.row]
        
        return detailControler
        
    }
    
}
