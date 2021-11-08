//
//  HeaderCell.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 05.11.2021.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView{
    
    let headerLabel = UILabel(text: "", font: UIFont(name: "Avenir Next ", size: 12), aligment: .right, textColor: .lightGray)
    
    override init(reuseIdentifier: String?){
        super .init(reuseIdentifier: reuseIdentifier)
        setConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(){
        
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
