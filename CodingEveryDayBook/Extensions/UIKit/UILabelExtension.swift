//
//  UILabelExtension.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 04.11.2021.
//

import UIKit

extension UILabel{
    convenience init(text: String, font: UIFont?, aligment: NSTextAlignment, textColor: UIColor ){
        self.init()
        self.text = text
        self.font = font
        self.textAlignment = aligment
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
