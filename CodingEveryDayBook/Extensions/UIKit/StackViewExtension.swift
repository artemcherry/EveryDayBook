//
//  StackViewExtension.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 04.11.2021.
//

import UIKit

extension UIStackView{
    convenience init(arrangedViews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution){
        self.init(arrangedSubviews: arrangedViews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
