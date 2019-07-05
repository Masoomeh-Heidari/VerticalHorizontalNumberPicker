//
//  HorizontalNumberPickerLineCell.swift
//
//  Created by Masoomeh Heidari on 4/2/1398 AP.
//

import UIKit

class HorizontalNumberPickerLineCell: UICollectionViewCell {
    
    public let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    public let lineNumberLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .green
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.semanticContentAttribute = .forceLeftToRight
        return lbl
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lineView)
        contentView.addSubview(lineNumberLbl)
    }
    
    public func calcLineViewHeight(_ index: Int, ancherNumber: Int) {
        if index % 5 == 0 && index % 10  == 0 {
            lineView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 80)
            lineView.backgroundColor = .green
            
            lineNumberLbl.frame = CGRect(x: -5, y: 80, width: 30, height: 15 )
            lineNumberLbl.text = "\(ancherNumber)"
            
        } else if index % 5 == 0 && index % 10  != 0{
            lineView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 65)
            lineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
            lineNumberLbl.frame = .zero
        } else {
            lineView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 50)
            lineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            lineNumberLbl.frame = .zero
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
