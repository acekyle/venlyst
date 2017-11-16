//
//  CustomExt.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/8/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit
import LBTAComponents


func pickRandomColor() -> UIColor{
    let colors: [UIColor] = [.blue, .red, .yellow, .gray, .bluVenyard, .ventageOrange, .purple, .magenta]
    let randomNumber  = arc4random_uniform(UInt32(colors.count))
    return colors[Int(randomNumber)]
}

func getTopViewController() -> UIViewController? {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while (topController.presentedViewController != nil){
            topController = topController.presentedViewController!
        }
        return topController
    }
    return nil
}

func makeTimestamp() -> Int {
    return Int(NSDate().timeIntervalSince1970)
}

func dismissKeyboardUsingTap(view: UIView=(getTopViewController()?.view)!){
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
}

extension UIColor{
    
        static let bluVenyard = UIColor(r: 151, g: 192, b: 216)
        static let ventageOrange = UIColor(r: 238, g: 106, b: 77)
    
}


extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color1.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


extension UIViewController {
    
    @available(iOS 5.0, *)
    func presentDatasource(_ viewControllerToPresent: SearchDatasourceController, animated flag: Bool, completion: (() -> Swift.Void)? = nil){}
    
    
}


extension UIFont {
    
    static let venFont: UIFont = UIFont(name: "Lato-Regular", size: 12)!
    
    func latoFont(type: String, size: CGFloat=12) -> UIFont {
        return UIFont(name: "Lato-" + type, size: size)!
    }
    
    
}


extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


typealias UnixTime = Int
extension UnixTime {
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    var toHour: String {
        return formatType(form: "HH:mm").string(from: dateFull)
    }
    var toDay: String {
        return formatType(form: "MM/dd").string(from: dateFull)
    }
}

extension UILabel {
    
    static func createLabel(text: String="Label", size: CGFloat=14, textColor: UIColor=UIColor.white, fontType: String="Regular", backgroundColor: UIColor=UIColor.clear, alignment: NSTextAlignment=NSTextAlignment.center, numberOfLines: Int=0) -> UILabel{
        let label = UILabel()
        let font = "Lato-" + fontType
        label.text = text
        label.textColor = textColor
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.font = UIFont(name: font, size: size)
        label.backgroundColor = backgroundColor
        return label
    }
}

extension UIView {
    
    static func createEmptyViewWithColor(backgroundColor: UIColor=UIColor.magenta, borderWidth: CGFloat=0, borderColor: CGColor=UIColor.white.cgColor, cornerRadius: CGFloat=0) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
        view.layer.cornerRadius = cornerRadius
        return view
    }
}

extension CachedImageView {
    
    static func createImageWith(imageOf: UIImage, contentMode: UIViewContentMode=UIViewContentMode.scaleAspectFit, backgroundColor:UIColor=UIColor.white) -> CachedImageView {
        let imgView = CachedImageView()
        imgView.layer.masksToBounds = true
        imgView.image = imageOf
        imgView.contentMode = contentMode
        imgView.backgroundColor = backgroundColor
        return imgView
    }
}


extension UICollectionView {
    
    static func createCollectionView(direction: UICollectionViewScrollDirection = .vertical) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.bounces = false
        collectionview.showsVerticalScrollIndicator  = false
        collectionview.showsHorizontalScrollIndicator  = false
        
        return collectionview
    }
}


extension UIButton {
    
    static func createButton(image: UIImage) -> UIButton {
        let butt = UIButton()
        butt.setImage(image, for: .normal)
        butt.imageView?.contentMode = .scaleAspectFit
        return butt
    }
    
}

extension UIStackView {
    
    static func createStackView(views: [UIView], axis: UILayoutConstraintAxis = .vertical, distribution: UIStackViewDistribution = .fillEqually, spacing: CGFloat = 0) -> UIStackView {
        let stack =  UIStackView(arrangedSubviews: views)
        stack.axis = axis
        stack.distribution = distribution
        stack.spacing = spacing
        return stack
    }
        
        
}


