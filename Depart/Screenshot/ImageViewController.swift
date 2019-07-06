//
//  ImageViewController.swift
//  Depart
//
//  Created by 濱田裕史 on 2019/07/06.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var imageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        scrollView.contentSize = imageView.frame.size
    }
}
