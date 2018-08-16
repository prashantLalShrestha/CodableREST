//
//  ViewController.swift
//  CodableRest
//
//  Created by Prashant Shrestha on 8/16/18.
//  Copyright © 2018 Prashant Shrestha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var apiClient = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        apiClient.send(GetPosts()) { (response) in
            switch response {
            case .success(let posts):
                print(posts)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

