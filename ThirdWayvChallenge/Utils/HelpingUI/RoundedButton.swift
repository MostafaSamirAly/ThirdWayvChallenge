//
//  RoundedButton.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 08/02/2022.
//

import UIKit

class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}

