//
//  ViewController.swift
//  ColorPicker-UIKit
//
//  Created by Begüm Arıcı on 21.02.2025.
//

import UIKit

class ViewController: UIViewController {

    let colorPicker: UIColorWell = {
        let colorPicker = UIColorWell()
        colorPicker.supportsAlpha = true
        colorPicker.selectedColor = .systemRed
        colorPicker.title = "Color Picker"
        return colorPicker
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Color Picker App"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed

        view.addSubview(titleLabel)
        view.addSubview(colorPicker)
        
        colorPicker.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.frame = CGRect(x: 20,
                                  y: view.safeAreaInsets.top+10,
                                  width: view.frame.size.width-40,
                                  height: 30)
        
        let colorPickerSize: CGFloat = 40
                colorPicker.frame = CGRect(x: view.frame.size.width - colorPickerSize - 20,
                                           y: view.safeAreaInsets.top + 10,
                                           width: colorPickerSize,
                                           height: colorPickerSize)
    }
    
    @objc private func colorChanged() {
        view.backgroundColor = colorPicker.selectedColor
    }
}

