//
//  MenuBar.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/9/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit
import LBTAComponents


class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "menuId"
    let menuArr = ["home-2", "search-2", "user-2", "menu-2"]
    var leftConstraint: NSLayoutConstraint?
    var homeController: SearchDatasourceController?
    
    lazy var collecionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        collecionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collecionView)
        collecionView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
       
        let selectedPath = NSIndexPath(item: 0, section: 0)
        collecionView.selectItem(at: selectedPath as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
        
        setupHorizontalBar()
        
    }
    
    func setupHorizontalBar() {
        let horizontal = UIView()
        horizontal.backgroundColor = .bluVenyard
        horizontal.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontal)
        

        leftConstraint = horizontal.leftAnchor.constraint(equalTo: self.leftAnchor)
        leftConstraint?.isActive = true
        
        horizontal.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontal.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 4).isActive = true
        horizontal.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collecionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.menuImageView.image = UIImage(named: menuArr[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.item) * frame.width / 4
//        leftConstraint?.constant = x
//        
//        UIView.animate(withDuration: 0.70, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
//        
//        UIView.animate(withDuration: 0.70) {
//            self.layoutIfNeeded()
//        }
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4 , height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class MenuCell: DatasourceCell {
    
    let menuImageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "home-2").withRenderingMode(.alwaysTemplate)
        img.tintColor = .gray
        return img
    }()
    
    override var isHighlighted: Bool {
        didSet{
            
            menuImageView.tintColor = super.isHighlighted ? .bluVenyard : .gray
        }
    }
    
    override var isSelected: Bool {
        didSet{
            
            menuImageView.tintColor = super.isSelected ? .bluVenyard : .gray
        }
    }
    
    override func setupViews() {
        super.setupViews()
    
        backgroundColor = .white
        
        addSubview(menuImageView)
        menuImageView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 24, heightConstant: 24)
        addConstraint(NSLayoutConstraint(item: menuImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: menuImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
