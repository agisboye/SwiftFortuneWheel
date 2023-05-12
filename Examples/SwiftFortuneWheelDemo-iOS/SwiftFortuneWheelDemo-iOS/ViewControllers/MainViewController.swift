//
//  ExamplesViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 6/7/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = "SwiftFortuneWheel"
    }
    
    var first = true
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard first else { return }
        let storyboard = UIStoryboard.init(name: "Various", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "\(VariousWheelSimpleViewController.self)") as? VariousWheelSimpleViewController
        guard let _viewController = viewController else { return }
        self.navigationController?.pushViewController(_viewController, animated: true)
        first = false
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
