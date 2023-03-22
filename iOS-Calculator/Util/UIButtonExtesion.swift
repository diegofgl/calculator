//
//  UIButtonExtesion.swift
//  iOS-Calculator
//
//  Created by Diego Rodrigues on 03/03/23.
//

import UIKit

private let orange = UIColor(red: 254/255, green: 148/255, blue: 0/255, alpha: 1)

extension UIButton {
    
    // Borda redonda
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    // Brilha
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
    
    //Botão de operação de seleção de aparência
    func selectOperation(_ selected: Bool) {
        //backgroundColor = selected ? .white : orange
        setTitleColor(selected ? orange : .white, for: .normal)
    }

}
