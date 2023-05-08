//
//  OnboaringSlide.swift
//  Yummie
//
//  Created by LI,JYUN-SIAN on 25/4/23.
//

import UIKit
//記憶體分成heap和stack兩塊。
//class物件是reference type，會被儲存在heap；struct物件是value type,會被存在stack。
//stack的執行效率會比heap好，所以一模一樣的事情，交給struct做，理論上會比class有效率

struct OnboardingSlide {
    let title: String
    let description: String
    let image: UIImage
}
