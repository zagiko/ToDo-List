//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Mike on 09.11.2022.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarckTaped(sender: ToDoTableViewCell)
}


class ToDoTableViewCell: UITableViewCell {

    
    weak var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var isCompleated: UIButton!
    @IBOutlet weak var titleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func isCompleatedButtonTapted(_ sender: UIButton) {
        delegate?.checkmarckTaped(sender: self)
        print("Button preced")
        
    }
    
    

}
