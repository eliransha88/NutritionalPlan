//
//  LoadingViewViewController.swift
//  UIComponentsPOC
//
//  Created by Gal Orlanczyk on 07/09/2018.
//  Copyright © 2018 GO. All rights reserved.
//

import UIKit
import UIComponents
import SwiftUI

struct LoadingViewViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoadingViewController")
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

class LoadingViewViewController: UITableViewController {

    let loadingViewOverlayService = LoadingViewOverlayService()
    @IBOutlet weak var loadingViewCellContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingView.createAndCenter(in: self.loadingViewCellContentView).startAnimating()
    }

    @IBAction func loadingViewOverlayServiceButtonTouched(_ sender: UIButton) {
        self.loadingViewOverlayService.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.loadingViewOverlayService.stop()
        }
    }
    
    @IBAction func loadingViewOverlayServiceWithDelayButtonTouched(_ sender: UIButton) {
        self.loadingViewOverlayService.start(delay: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.loadingViewOverlayService.stop()
        }
    }
}
