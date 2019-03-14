//
//  ViewController.swift
//  TesteDaImagePorUrl
//
//  Created by Guilherme Takakuwa on 3/13/19.
//  Copyright © 2019 Guilherme Takakuwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var backgroudShow: UIImageView!
    @IBOutlet weak var poster1: UIImageView!
   
    @IBOutlet weak var titulo1: UITextView!
    @IBOutlet weak var genero1: UITextView!
    @IBOutlet weak var descricao1: UITextView!
    

    let urlKey = "http://static.tvmaze.com/uploads/images/original_untouched/1/3603.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       showImage(self)
        
        titulo1.layer.cornerRadius = 15
        genero1.layer.cornerRadius = 15
        descricao1.layer.cornerRadius = 15
    }

    func showImage(_ sender: Any) {
    
    if let url = URL(string: urlKey){
        
        do {
            let data = try Data(contentsOf: url)
            self.poster1.image = UIImage(data: data)
            
        }catch let err {
            print(" Error : \(err.localizedDescription)")
        }
    }
}

    
    
}
