//
//  CardView.swift
//  Assignment
//
//  Created by Aniket Kumar on 14/04/24.
//

import Foundation
import UIKit

@IBDesignable class CardView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 2.0
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOffsetWidth: CGFloat = 0
    @IBInspectable var shadowOffsetHeight: CGFloat = 2
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
}
