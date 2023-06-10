//
//  CornerRadius+Extension.swift
//  musicApp
//
//  Created by Asude Nisa Tıraş on 9.06.2023.
//

import UIKit


extension UIView {

   @IBInspectable var cornerRadius: CGFloat{
       get{return self.cornerRadius}
       set{
            self.layer.cornerRadius = newValue
        }
    }
}
