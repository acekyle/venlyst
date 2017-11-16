//
//  FavoritesDatasourceController.swift
//  VenueLyst
//
//  Created by Aaron Anderson on 6/30/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import LBTAComponents

class FavoritesDatasourceController: DatasourceController {
    
    let cellId = "favsCell"
    let noActivityCellId = "activityCell"

    var currentUser: [User]?
    let coreHelper = CoreStack()
    var favoriteVenues = [Venue]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavorites), name:NSNotification.Name(rawValue: "reload"), object: nil)
        setupCollectionView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        updateFavoriteVenues()
    }
    
    func reloadFavorites(notification: NSNotification){
        currentUser = coreHelper.fetchUserData()
        updateFavoriteVenues()
        collectionView?.reloadData()
    }
    
    func updateFavoriteVenues(){
        
        currentUser = coreHelper.fetchUserData()
        if currentUser!.count > 0 {
            
            guard let user = currentUser?[0] else { return }
            guard let favs = coreHelper.fetchVenueDataByIds(ids: user.favorites as! [String]) else { return }
            
            self.favoriteVenues = favs
        }

        collectionView?.reloadData()
    }
    
    func setupCollectionView(){
        collectionView?.register(NoActivityCell.self, forCellWithReuseIdentifier: noActivityCellId)
        collectionView?.register(FavoriteVenuesCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white //UIColor(r: 242, g: 242, b: 242)
        collectionView?.showsVerticalScrollIndicator  = false
        collectionView?.showsHorizontalScrollIndicator  = false
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.isPagingEnabled = false
        collectionView?.isScrollEnabled = true
        collectionView?.bounces = false
        collectionView?.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupNavView() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if favoriteVenues.count > 0 {
            return CGSize(width: view.frame.width, height: view.frame.height / 2 - 12.5)
        }
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if favoriteVenues.count > 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FavoriteVenuesCell
            cell.backgroundColor = .white
            cell.favoriteVenue = favoriteVenues[indexPath.item]
            
            print("Favorites Index: ", favoriteVenues[indexPath.item])
            
            cell.favButton.setImage(#imageLiteral(resourceName: "likeButtonFilled"), for: .normal)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noActivityCellId, for: indexPath) as! NoActivityCell
            cell.noActivityLabel.text = "Add venues to favorites"
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoriteVenues.count > 0 {
            return favoriteVenues.count
        }
        return 1
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FavoriteVenuesCell
        let stackDetailsController = StackedDetailsView()
        if let id = cell?.favoriteVenue?.id {
            guard let venue = coreHelper.fetchVenueDataById(id: String(id))?[0] else { return }
            stackDetailsController.venueObject = venue
            self.present(stackDetailsController, animated: false, completion: nil)
        }
        
    }
    
}

class NoActivityCell: DatasourceCell {
    
    override func setupViews() {
        super.setupViews()
        
        configureView()
    }
    
    override var datasourceItem: Any? {
        
        didSet {
            
        }
        
    }
    
    let noActivityView = UIView.createEmptyViewWithColor(backgroundColor: .clear)
    let noActivityLabel = UILabel.createLabel(text: "", size: 16, textColor: .lightGray, fontType: "Regular", backgroundColor: .clear, alignment: .center, numberOfLines: 0)
    
    func configureView() {
    
        addSubview(noActivityView)
        noActivityView.addSubview(noActivityLabel)
        noActivityView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        noActivityLabel.anchor(topAnchor, left: nil, bottom: nil, right: nil, topConstant: frame.height / 2 - 25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width, heightConstant: 50)
    }
    
    
}














