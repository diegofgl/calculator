//
//  UIButtonExtesion.swift
//  iOS-Calculator
//
//  Created by Diego Rodrigues on 03/03/23.
//

import UIKit

extension UIButton{
    
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

}
