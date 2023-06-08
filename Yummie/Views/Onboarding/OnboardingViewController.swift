//
//  OnboardingViewController.swift
//  Yummie
//
//  Created by LI,JYUN-SIAN on 24/4/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // 建立slides初始化
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
    // 如果 currentPage 的值等於 slides.count - 1，也就是目前的頁面是最後一頁，則將 nextBtn 的標題設為 "Get Started"。
    // 否則，將 nextBtn 的標題設為 "Next"
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // 取用model定義好的屬性，定義這slides內，每個 OnboardingSlide 包含title,description,image等三個屬性
        slides = [
            OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.", image: #imageLiteral(resourceName: "slide2")),
            OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: #imageLiteral(resourceName: "slide1")),
            OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: #imageLiteral(resourceName: "slide3"))
        ]
        pageControl.numberOfPages = slides.count
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
   // 現在是最後1頁，讓controller創建一個HomeNC UINavigationController來覆蓋當前畫面，會以水平翻轉轉場到UINavigationController
        if currentPage == slides.count - 1 {
    print("go to next page")
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
  // 反之，現在不在最後1頁，程式會將currentPage值加1，使用indexPath來指定新頁面位置，是由currentPage值加1得來的，實現分頁導覽滑動效果
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true )
        }
    }
}

    
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //向特定資料詢問並回傳
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return slides.count
    }
    //呼叫相對應的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //cell可以辨識重覆使用的cell,確定轉換成功用as!
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
            cell.setup(slides[indexPath.row])
            return cell
    }
    // 回傳cell layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    //告訴委託人畫面滑動結束
    // 讓滑動照片呈現矩形
    //來檢視目前原點位置跟偏移位置差異
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

