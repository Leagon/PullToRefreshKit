//
//  DefaultCollectionViewController.swift
//  PullToRefreshKit
//
//  Created by huangwenchen on 16/7/13.
//  Copyright © 2016年 Leo. All rights reserved.
//

import Foundation
import UIKit
import PullToRefreshKit

class DefaultCollectionViewController:UIViewController,UICollectionViewDataSource{
    var collectionView:UICollectionView!
    var count = 9
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.setUpCollectionView()
        self.collectionView.configRefreshHeader(with: DefaultRefreshHeader.header()) { [weak self] in
            delay(1.0, closure: {
                self?.collectionView.switchRefreshHeader(to: .normal(.success, 0.5));
            });
        }
        self.collectionView.configRefreshFooter(with: DefaultRefreshFooter.footer()) { [weak self] in
            delay(1.0, closure: {
                guard let sf = self else{
                    return
                }
                sf.count = sf.count + 3
                sf.collectionView.reloadData()
                sf.collectionView.switchRefreshFooter(to: .normal)
            });
        };

    }
    func setUpCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
        self.collectionView = UICollectionView(frame:frame, collectionViewLayout: flowLayout)
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.dataSource = self
        self.view.addSubview(self.collectionView!)
        
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    deinit{
        print("Deinit of DefaultCollectionViewController")
    }
}
