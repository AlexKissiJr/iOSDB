//
//  ViewController.swift
//  iOSDB
//
//  Created by Alexander Kissi Jr on 7/8/19.
//  Copyright © 2019 Createlex. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {

    @IBOutlet weak var movieLargePosterImage: UIImageView!
    @IBOutlet weak var moiveSummary: UITextView!
    
    @IBOutlet weak var mainMovieTitle: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLargeImage()
        loadMovieText()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadLargeImage()
        loadMovieText()

    }
    
    override func viewWillDisappear(_ animated: Bool) {

        mainImage = nil
    }

    
    func loadLargeImage(){
        movieLargePosterImage.image = mainImage
    }
    
    func loadMovieText()
    {
        moiveSummary.text = mainMoiveSummary
        mainMovieTitle.text = mainMoiveTitleInfo
        

    }
    

}

