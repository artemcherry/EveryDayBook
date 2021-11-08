//
//  AlertName.swift
//  CodingEveryDayBook
//
//  Created by Артем Вишняков on 05.11.2021.
//

import UIKit

extension UIViewController{
    
    func alertNameCell(label: UILabel, name: String, placeholder: String, completionHandler: @escaping(String) -> Void){
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            
            let alertTF = alert.textFields?.first
            guard let text = alertTF?.text else { return }
            
            label.text = text
            completionHandler(text)
        }
        alert.addTextField { alertTF in
            alertTF.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
}
