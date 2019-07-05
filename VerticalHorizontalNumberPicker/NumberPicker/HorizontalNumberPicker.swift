//
//  HorizontalNumberPicker.swift
//
//  Created by Masoomeh Heidari on 4/2/1398 AP.
//

import UIKit

class HorizontalNumberPicker: UIView {
    
    public var delegate: NumberPickerDelegate!
    public var maxNumber: Int!
    
    public var bgGradients: [UIColor] = [.white, .white]
    public var heading = ""
    public var defaultSelectedNumber: Int = 0
    
    let flowLayout = UICollectionViewFlowLayout()
    
    lazy var collectionView: UICollectionView = {
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemSize = CGSize(width: 1, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.semanticContentAttribute = .forceLeftToRight
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var cellWidthIncludingSpacing: CGFloat {
        return flowLayout.itemSize.width + flowLayout.minimumLineSpacing
    }
    
    let cellId = "cellId"
    
    lazy var arrowImageView: UIImageView = {
        let img: UIImage = UIImage(named:"arrowVertical")!
        let imgView = UIImageView(image: img.withRenderingMode(.alwaysTemplate))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleToFill
        imgView.tintColor = .red
        return imgView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(delegate: NumberPickerDelegate, maxNumber: Int, frame: CGRect) {
        super.init(frame: frame)
        self.delegate = delegate
        self.maxNumber = maxNumber
        initializeViews()
        addViews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.scrollToDefaultNumber(self.defaultSelectedNumber)
        }
    }
    
    func initializeViews() {
        collectionView.register(HorizontalNumberPickerLineCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func addViews() {        
        self.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 152).isActive = true
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: self.bounds.width / 2, bottom: 0, right: self.bounds.width / 2)
        
        self.addSubview(arrowImageView)
        arrowImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        arrowImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    
    func scrollToDefaultNumber(_ number: Int) {
        if number <= 0 { return }
        if number > maxNumber { return }
        let offset = CGPoint(x: CGFloat(number) * cellWidthIncludingSpacing - collectionView.contentInset.right, y: -collectionView.contentInset.top)
        collectionView.setContentOffset(offset, animated: true)
    }
    
    
    func createView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
}

extension HorizontalNumberPicker: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxNumber + 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            as! HorizontalNumberPickerLineCell
        let ancherNumber = indexPath.row % 10 == 0 ? indexPath.row : 0
        cell.calcLineViewHeight(indexPath.row, ancherNumber: ancherNumber)
        return cell
    }
}

extension HorizontalNumberPicker: UIScrollViewDelegate {
    
    // this is for exactly stop on line
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.right) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.right, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset
        let index = (offset.x + scrollView.contentInset.right) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        delegate.selectedNumber(roundedIndex <= 0 ? 0 : Int(roundedIndex))
    }
}
