//
//  TaskCell.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 04.11.2021.
//

import UIKit

class TaskCell: UITableViewCell{

    
    let taskName = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 20), aligment: .left, textColor: .black)
    let descriptionTask = UILabel(text: "", font: UIFont(name: "Avenir Next", size: 20), aligment: .left, textColor: .gray)
    let taskTime = UILabel(text: "15:00", font: UIFont(name: "Avenir Next", size: 20), aligment: .right, textColor: .gray)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        descriptionTask.numberOfLines = 2
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: TaskModel){
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        taskName.text = model.name
        descriptionTask.text = model.descriptionTask
        taskTime.text = dateFormater.string(from: model.date_start)
    }

    func setConstraints(){
        
        let leftStackView = UIStackView(arrangedViews: [taskName, descriptionTask], axis: .vertical, spacing: 0, distribution: .fillEqually)

        self.addSubview(leftStackView)
        NSLayoutConstraint.activate([
            leftStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            leftStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            leftStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            leftStackView.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        self.addSubview(taskTime)
        NSLayoutConstraint.activate([
            taskTime.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            taskTime.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor, constant: 0),
            taskTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            taskTime.heightAnchor.constraint(equalToConstant: 45),
        ])
 
    }
    
}
