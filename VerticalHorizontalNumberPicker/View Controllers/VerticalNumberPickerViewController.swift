//
//  VerticalNumberPickerViewController.swift
//
//  Created by Masoomeh Heidari on 4/14/1398 AP.
//

import UIKit

class VerticalNumberPickerViewController: UIViewController , NumberPickerDelegate{

    @IBOutlet weak var numberPickerView: UIView!
    @IBOutlet weak var numberPickerSelectedValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBorderToSelectedValueLabel()
                
        let numberPicker = VerticalNumberPicker(delegate: self, maxNumber: 300, frame: self.numberPickerView.bounds)
        numberPicker.defaultSelectedNumber = 150
        
        self.numberPickerView.addSubview(numberPicker)

    }
    
    func addBorderToSelectedValueLabel() {
        let frame = numberPickerSelectedValueLabel.frame
        
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        bottomLayer.backgroundColor = UIColor.lightGray.cgColor
        numberPickerSelectedValueLabel.layer.addSublayer(bottomLayer)
        
        let topLayer = CALayer()
        topLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: 1)
        topLayer.backgroundColor = UIColor.lightGray.cgColor
        numberPickerSelectedValueLabel.layer.addSublayer(topLayer)
    }

    func selectedNumber(_ number: Int) {
        self.numberPickerSelectedValueLabel.text = "\(number) Centimeter"
    }
}

