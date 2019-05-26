//
//  ProductVC.swift
//  DanTang
//
//  Created by 品德信息 on 2017/8/1.
//  Copyright © 2017年 品德信息. All rights reserved.
//

import UIKit

private let cellId = "collectionViewId"

class ProductVC: TXBaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    var collectionView:UICollectionView?
    var datas = [ProductModel]()//数组
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCollectionView()
        self.requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.requestData()
    }
    private func requestData(){
        NetworkTool.shared.loadProductData { [weak self](data) in
            self?.datas = data
            self?.collectionView?.reloadData()
        }
    }
    
    private  func initCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        let width:CGFloat = (KScreenWidth - 20)/2
        let height:CGFloat = 245
        layout.itemSize = CGSize(width:width,height:height)
//        public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)

        collectionView = UICollectionView(frame:view.bounds ,collectionViewLayout:layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.frame = view.bounds
        collectionView?.backgroundColor = view.backgroundColor
        view.addSubview(collectionView!)
        
        
//        open func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String)

        collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        cell.model = datas[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = datas[indexPath.row]
        let vc = ProductDetailVC()
        vc.id = model.id!
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
