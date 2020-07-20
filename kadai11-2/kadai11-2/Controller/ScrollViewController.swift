//
//  ScrollViewController.swift
//  kadai11-2
//
//  Created by 葛西　佳祐 on 2020/07/19.
//  Copyright © 2020 葛西　佳祐. All rights reserved.
//

import UIKit
import Lottie

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var onboardArray = ["11-1","11-2","11-3","11-4","11-5"]
    
    var onboardStringArray = ["本を読み、知見を広げましょう",
        "読書の感想を記録するアプリです",
        "お気に入りの本を登録して、気軽にシェアしましょう",
        "AR機能はどのようにつけたか乞うご期待",
        "さあ、始めよう！"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.isPagingEnabled = true
        setUpScroll()
        
        for i in 0...4 {
            let animationView = AnimationView()
            let animation = Animation.named(onboardArray[i])
            animationView.frame = CGRect(x: CGFloat(i)*view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animation
            //画像配置をコードで指定
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            scrollView.addSubview(animationView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpScroll(){
        scrollView?.delegate = self
        scrollView?.contentSize = CGSize(width: view.frame.size.width * 5, height: scrollView.frame.size.height)
        for i in 0...4{
           let onboardLabel = UILabel(frame: CGRect(x: CGFloat(i)*view.frame.size.width, y: view.frame.size.height/3, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
           onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
           onboardLabel.textAlignment = .center
           onboardLabel.text = onboardStringArray[i]
           scrollView.addSubview(onboardLabel)
            }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
