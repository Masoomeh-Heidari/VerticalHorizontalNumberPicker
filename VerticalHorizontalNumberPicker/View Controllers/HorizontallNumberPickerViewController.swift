//
//  HorizontallNumberPickerViewController.swift
//
//  Created by Masoomeh Heidari on 4/14/1398 AP.
//

import UIKit

class HorizontallNumberPickerViewController: UIViewController , NumberPickerDelegate {

    
    @IBOutlet weak var numberPickerView: UIView!
    @IBOutlet weak var numberPickerSelectedValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorderToSelectedValueLabel()

        let numberPicker = HorizontalNumberPicker(delegate: self, maxNumber: 300, frame: self.numberPickerView.bounds)
        numberPicker.defaultSelectedNumber = 70
        self.numberPickerView.addSubview(numberPicker)
    }
    
    func addBorderToSelectedValueLabel() {
        let frame = numberPickerSelectedValueLabel.frame
        
        let leftLayer = CALayer()
        leftLayer.frame = CGRect(x: frame.width - 1, y: 0, width: 1, height: frame.height)
        leftLayer.backgroundColor = UIColor.lightGray.cgColor
        numberPickerSelectedValueLabel.layer.addSublayer(leftLayer)
        
        let rightLayer = CALayer()
        rightLayer.frame = CGRect(x: 0, y: 0, width: 1, height: frame.height)
        rightLayer.backgroundColor = UIColor.lightGray.cgColor
        numberPickerSelectedValueLabel.layer.addSublayer(rightLayer)
    }
    
    func selectedNumber(_ number: Int) {
        self.numberPickerSelectedValueLabel.text = "\(number) Kilogaram"
    }
    

    

}
