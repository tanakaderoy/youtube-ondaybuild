//
//  ViewController.swift
//  youtube-onedaybuild
//
//  Created by Tanaka Mazivanhanga on 11/25/20.
//

import UIKit

class ViewController: UIViewController {
    var model: Model?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        model = Model()
        model?.getVideos()
    }


}

