//
//  Utilities.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 26/04/24.
//

import UIKit

class UIHelper {
    static func createCollectionFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let coloumn: CGFloat = 3
        let minimumSpacing:CGFloat = 10
        
        let actualWidth = view.bounds.width - minimumSpacing*(coloumn-1) - 20
        
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.sectionInset = UIEdgeInsets(top: padding , left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: actualWidth/coloumn, height: actualWidth/coloumn)
        return flowLayout
    }
}
