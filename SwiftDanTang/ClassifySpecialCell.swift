//
//  ClassifySpecialCell.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/8/29.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit
let categoryCollectionCellID = "categoryCollectionCellID"

class ClassifySpecialCell: TableViewCellExt,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var collectionView:UICollectionView?
    var model = [SpecialModel]()
    var datas :[SpecialModel]?{
        didSet {
            if(datas != nil) && (datas?.count)! > 0 {
                model = datas!
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func initView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame:CGRect(x:0,y:0,width:KScreenWidth,height:ClassifySpecialCell.cellHeight()),collectionViewLayout:flowLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
        collectionView?.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(collectionView!)
        
        let cellNib = UINib(nibName:String(describing:CategoryCollectionViewCell.self),bundle:nil)
        collectionView?.register(cellNib, forCellWithReuseIdentifier: categoryCollectionCellID)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionCellID, for: indexPath) as! CategoryCollectionViewCell
        cell.name = model[indexPath.row].banner_image_url
        return cell
    }
    

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)
    }

    class func cellHeight() -> CGFloat{
    
        return 100
    }

}
