//
//  UIView+Extension.swift
//  Yummie
//
//  Created by LI,JYUN-SIAN on 25/4/23.
//

import UIKit

// 因為重覆用到view屬性，用extension擴展屬性
// 透過指定屬性為IBInspectable，可以直接使用顏色選擇器直接進行編輯
// get是读取属性时进行的操作，set是设置属性时进行的操作。

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

