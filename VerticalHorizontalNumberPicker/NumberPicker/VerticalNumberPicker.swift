//
//  VerticalNumberPicker.swift
//
//  Created by Masoomeh Heidari on 3/28/1398 AP.
//
//Inspired from https://github.com/yashthaker7/NumberPicker


import UIKit

public protocol NumberPickerDelegate {
    func selectedNumber(_ number: Int)
}

public class VerticalNumberPicker: UIView {
    
    public var delegate: NumberPickerDelegate!
    public var maxNumber: Int!
    
    public var bgGradients: [UIColor] = [.white, .white]
    public var heading = ""
    public var defaultSelectedNumber: Int = 0
    
    let flowLayout = UICollectionViewFlowLayout()
    
    lazy var collectionView: UICollectionView = {
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 3
        flowLayout.itemSize = CGSize(width: self.bounds.width, height: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var cellHeightIncludingSpacing: CGFloat {
        return flowLayout.itemSize.height + flowLayout.minimumLineSpacing
    }
    
    let cellId = "cellId"
    
    lazy var arrowImageView: UIImageView = {
        let img: UIImage = UIImage(named:"arrowHorizontal")!
        let imgView = UIImageView(image: img.withRenderingMode(.alwaysTemplate))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
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
        collectionView.register(VerticalNumberPickerLineCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func addViews() {
        self.applyGradient(colors: bgGradients, type: .vertical)
        self.roundCorners([.topLeft, .bottomLeft], radius: 10)
        
        self.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top:self.bounds.height/2, left: 0, bottom: self.bounds.height/2, right: 0)
        
        self.addSubview(arrowImageView)
        
        
        arrowImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
    
    func scrollToDefaultNumber(_ number: Int) {
        if number <= 0 { return }
        if number > maxNumber { return }
        let offset = CGPoint(x: 0, y: CGFloat(number) * cellHeightIncludingSpacing - collectionView.contentInset.top)
        collectionView.setContentOffset(offset, animated: true)
    }
    
    
    func createView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
}

extension VerticalNumberPicker: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxNumber + 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            as! VerticalNumberPickerLineCell
        cell.calcLineViewHeight(indexPath.row, maxNumber : maxNumber)
        return cell
    }
}

extension VerticalNumberPicker: UIScrollViewDelegate {
    
    // this is for exactly stop on line
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var offset = targetContentOffset.pointee
        let index = (offset.y + scrollView.contentInset.top) / cellHeightIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: -scrollView.contentInset.right , y: roundedIndex * cellHeightIncludingSpacing - scrollView.contentInset.top )
        targetContentOffset.pointee = offset
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset
        let index = (offset.y + scrollView.contentInset.top) / cellHeightIncludingSpacing
        let roundedIndex = Int(round(index))
        
        delegate.selectedNumber((maxNumber - roundedIndex) <= 0 ? 0 : Int(maxNumber - roundedIndex))
    }
}



