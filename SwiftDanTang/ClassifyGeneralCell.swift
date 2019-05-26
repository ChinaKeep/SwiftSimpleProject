//
//  ClassifyGeneralCell.swift
//  SwiftDanTang
//
//  Created by 品德信息 on 2017/8/30.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit
let cellID = "ClassifyCollectionViewCellID"

class ClassifyGeneralCell: TableViewCellExt ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var collectionView: UICollectionView?
    var model = [GroupModel]()
    var datas: [GroupModel]?{
        didSet {
            if (datas != nil) && (datas?.count)!>0 {
                model = datas!
                self.refreshCollectionView()
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func initView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame:CGRect(x:0,y:0,width:KScreenWidth,height:100),collectionViewLayout:flowLayout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.isScrollEnabled = false
        self.contentView.addSubview(collectionView!)
        collectionView?.register(ClassifyCollectionViewCell.self,forCellWithReuseIdentifier:cellID)
    }
    
    //MARK: collectionView Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ClassifyCollectionViewCell
        cell.model = model[indexPath.row]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = datas?[indexPath.row]
        let vc = ClassifyContentVC()
        vc.id = (model?.id)!
        vc.title = model?.name
        vc.type = ClassifyContentVCType.ClassifyOthers
        
        
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (KScreenWidth-50)/4, height: (KScreenWidth-50)/4+30)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)
    }
    
    
    fileprivate func refreshCollectionView(){
        self.collectionView?.height = ClassifyGeneralCell.cellHeight(datas:model)
    }
    
    class func cellHeight(datas:[GroupModel]) -> CGFloat{
        
        if datas.count <= 4{
            return (KScreenWidth - 50)/4+30
        }else{
//            round：如果参数是小数，则求本身的四舍五入。
//            ceil：如果参数是小数，则求最小的整数但不小于本身.
//            floor：如果参数是小数，则求最大的整数但不大于本身.

            return ceil(CGFloat(Double(datas.count)/4))*((KScreenWidth - 50)/4 + 30 + 2*kMargin)
        }
        
    }
    
}
