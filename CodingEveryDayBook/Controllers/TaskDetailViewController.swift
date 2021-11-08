//
//  TaskDetailTableView.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 06.11.2021.
//

import UIKit
import RealmSwift

class TaskDetailViewController: UIViewController{
    
    let taskCell = TaskCell()
    
    let nameLabel = UILabel(text: "Name", font: UIFont(name: "Avenir Next Demi Bold", size: 25), aligment: .left, textColor: .blue)
    let timeLabel = UILabel(text: "Time", font: UIFont(name: "Avenir Next ", size: 22), aligment: .left, textColor: .black)
    let descriptionLabel = UILabel(text: "Description", font: UIFont(name: "Avenir Next ", size: 20), aligment: .left, textColor: .black)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        setConstraints()
        
    }
    
        
        func setConstraints(){
            view.addSubview(nameLabel)
            descriptionLabel.numberOfLines = 0
            
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
            ])
            
            
            view.addSubview(timeLabel)
            
            NSLayoutConstraint.activate([
                timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 35),
                timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
            ])
            
            view.addSubview(descriptionLabel)
            
            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                descriptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 35),
                descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
            ])
        }
}
