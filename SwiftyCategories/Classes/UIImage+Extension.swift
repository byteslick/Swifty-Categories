//
//  UIImage+Extension.swift
//  SwiftyCategories
//
//  Created by Madhup Yadav on 18/09/19.
//

import UIKit

public extension UIImage{
    
    func roundedImage(_ radius:CGFloat? = nil, _ borderWidth: CGFloat? = nil, _ borderColor: UIColor? = nil) -> UIImage{
        let imageView = UIImageView.init(image: self)
        let scale = UIScreen.main.scale
        imageView.frame = CGRect(origin: CGPoint.zero, size: self.size)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.clear
        if borderWidth != nil{
            imageView.layer.borderWidth = borderWidth!
            if borderColor != nil{
                imageView.layer.borderColor = borderColor?.cgColor
            }
        }
        imageView.layer.cornerRadius = radius ?? 5
        imageView.contentScaleFactor = scale
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        imageView.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
