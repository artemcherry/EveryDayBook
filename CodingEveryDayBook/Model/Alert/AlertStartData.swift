//
//  AlertData.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 05.11.2021.
//

import UIKit

extension UIViewController{
    
    func alertStartDate(label: UILabel, completionHandler: @escaping(Date) -> Void){
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "Ru_ru") as Locale
        
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy HH:mm"
            let dateString = dateFormater.string(from: datePicker.date)
            
            let date = datePicker.date 
            completionHandler(date)
            
            label.text = dateString
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
