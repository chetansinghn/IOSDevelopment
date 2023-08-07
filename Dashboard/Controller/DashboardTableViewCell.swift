//
//  DashboardTableViewCell.swift
//  iOSArchitecture_MVVM
//
//  Created by Chetan Singh Negi on 19/07/23.
//  Copyright © 2023 Surjeet Singh. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    let imageArray: [UIImage] = [UIImage(named: "Group 117")!,UIImage(named: "Group 92")!,UIImage(named: "Group 117")!]
    
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        // Initialization code
    }
    
}
 
extension DashboardTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imageArray.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! DashboardCollectionViewCell
        
        let image = imageArray[indexPath.item]

        cell.imageView.image = image
        cell.imageView.contentMode = .scaleAspectFit

        return cell

    }

    

}
