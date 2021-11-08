//
//  EverydayBookViewController.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 04.11.2021.
//

import UIKit
import FSCalendar
import RealmSwift

class EverydayBookViewController: UIViewController {
    
    var calendarHeightContraint = NSLayoutConstraint()
    
    var calendar: FSCalendar = {
       let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    var showHideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open Calendar", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel!.font = UIFont(name: "Avenir Next Demi Bold", size: 14)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let localRealm = try! Realm()
    var taskArray: Results<TaskModel>!
    
    let cellIdentifier = "TaskCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Everyday Book"
        
        
        setConstraints()
        

        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .week
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: cellIdentifier)
        
        showHideButton.addTarget(self, action: #selector(showHideButtonPressed), for: .touchUpInside)
        
        swipeAction()
        
        taskOnDay(date: Date())
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func showHideButtonPressed() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open Calendar", for: .normal)
        }
    }
    
    @objc func addButtonTapped(){
        let addTaskVC = TaskAddTableViewController()
        navigationController?.pushViewController(addTaskVC, animated: true)
    }
    
    private func taskOnDay(date: Date){
        let calendar = Calendar.current
        
        let startDate = date
        let endDate: Date = {
            let components = DateComponents(day: 1, second: -1)
            return calendar.date(byAdding: components, to: startDate)!
        }()
        
        let predicate = NSPredicate(format: "date_start BETWEEN %@", [startDate, endDate])
        
        taskArray = localRealm.objects(TaskModel.self).filter(predicate).sorted(byKeyPath: "date_start")
        tableView.reloadData()
    }
    
    
    //MARK: - Swipe GestureRecogniser
    func swipeAction () {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            showHideButtonPressed()
        case .down:
            showHideButtonPressed()
        default:
            break
        }
    }
}


//MARK: - TableViewDataSource, UITableViewDelegate
extension EverydayBookViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TaskCell
        let model = taskArray[indexPath.row]
        cell.configureCell(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskDetailVC = TaskDetailViewController()
        
        navigationController?.pushViewController(taskDetailVC.self, animated: true)
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        
        let model = taskArray[indexPath.row]
        taskDetailVC.nameLabel.text = "Task: \(model.name)"
        taskDetailVC.timeLabel.text = "Time: \(dateFormater.string(from: model.date_start))"
        taskDetailVC.descriptionLabel.text = "Description: \n \(model.descriptionTask)"
       
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = taskArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, competionHandler in
            RealmManager.shared.deleteTask(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}

//MARK: - Calendar
extension EverydayBookViewController:FSCalendarDataSource, FSCalendarDelegate{
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightContraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        taskOnDay(date: date)
    }
    
}

//MARK: - Constarints

extension EverydayBookViewController{
    
    func setConstraints() {
        view.addSubview(calendar)
        
        calendarHeightContraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        
        calendar.addConstraint(calendarHeightContraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(showHideButton)
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.widthAnchor.constraint(equalToConstant: 100),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
 
