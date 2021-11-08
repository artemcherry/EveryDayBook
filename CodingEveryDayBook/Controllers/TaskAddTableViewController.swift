//
//  TaskAddTableViewController.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 05.11.2021.
//

import UIKit

class TaskAddTableViewController: UITableViewController{
    
    let cellIdentifier = "NewTaskCell"
    let headerIdentifier = "HeaderCell"
    
    private let taskModel = TaskModel()
    
    let headerTitlesArray = ["Date", "Name", "Description"]
    
    let cellLabelNames = [["Starting Date", "Finish Date"],
                          ["Name"],
                          ["Description"]]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Task"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewTaskCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.97, alpha: 1)
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped(){
        RealmManager.shared.saveTask(model: taskModel)
        
        
        let alert = UIAlertController(title: "Task saved", message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
  
    //MARK: - TabeleViewDelegate, TableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0 : return 2
        case 1 : return 1
        default : return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewTaskCell
        cell.cellLabel.text = cellLabelNames[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! HeaderCell
        header.headerLabel.text = headerTitlesArray[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewTaskCell
        switch indexPath{
        case [0,0] : alertStartDate(label: cell.cellLabel) { date in
            self.taskModel.date_start = date
        }
        case [0,1]: AlertEndDate(label: cell.cellLabel) { date in
            self.taskModel.date_finish = date
        }
        case [1,0]: alertNameCell(label: cell.cellLabel, name: "Name", placeholder: "Enter task name"){ text in
            self.taskModel.name = text}
        case [2,0]: alertNameCell(label: cell.cellLabel, name: "Description", placeholder: "Enter description for the task"){ text in
            self.taskModel.descriptionTask = text
        }
        default: print("12341")
        }
        
}
}
