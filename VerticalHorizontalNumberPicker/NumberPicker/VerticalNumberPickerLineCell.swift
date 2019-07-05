//
//  VerticalNumberPickerLineCell.swift
//
//  Created by Masoomeh Heidari on 3/28/1398 AP.
//
//Inspired from https://github.com/yashthaker7/NumberPicker


import UIKit

public class VerticalNumberPickerLineCell: UICollectionViewCell {
    
    public let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    public let lineNumberLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .green
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.contentMode = .bottomLeft
        return lbl
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lineView)
        contentView.addSubview(lineNumberLbl)    }
    
    public func calcLineViewHeight(_ index: Int, maxNumber: Int) {
        if index % 5 == 0 && index % 10  == 0 {
            lineView.frame = CGRect(x: bounds.width - 80, y: 0, width: 80, height: 1 )
            lineView.backgroundColor = .green
            
            lineNumberLbl.frame = CGRect(x: 0, y: 3, width: 50, height: 18 )
            lineNumberLbl.text = "\(maxNumber - index)"
            
        } else if index % 5 == 0 && index % 10  != 0{
            lineView.frame = CGRect(x: bounds.width - 65, y: 2, width: 65, height: 1)
            lineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
            lineNumberLbl.frame = .zero
        } else {
            lineView.frame = CGRect(x: bounds.width - 50, y: 2, width: 50, height: 1)
            lineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            lineNumberLbl.frame = .zero
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
