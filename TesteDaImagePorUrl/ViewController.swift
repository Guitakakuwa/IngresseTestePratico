//
//  ViewController.swift
//  TesteDaImagePorUrl
//
//  Created by Guilherme Takakuwa on 3/13/19.
//  Copyright © 2019 Guilherme Takakuwa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet weak var backgroudShow: UIImageView!
    @IBOutlet weak var poster1: UIImageView!
    @IBOutlet weak var titulo1: UITextView!
    @IBOutlet weak var genero1: UITextView!

    let showDataModel = ShowDataModel()
    
    let api:String = "http://api.tvmaze.com/search/shows?q=rick"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       showImage(self)
        getAPI(url:api)
        titulo1.layer.cornerRadius = 15
        genero1.layer.cornerRadius = 15
        
    }

    func getAPI(url: String) {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let retornoApi = JSON(response.result.value!)
                self.setInfoShows(json:retornoApi)
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
        
    }
    
    func updateUserUI() {
        setImage(self, api: showDataModel.posterImage)
        titulo1.text = showDataModel.showName
        genero1.text = showDataModel.showGenres
    }
    
    func setInfoShows (json:JSON) {
        if  let posterImage:String = json[0]["show"]["image"]["medium"].stringValue {
            print(json)
            print("entrou")
            showDataModel.posterImage =  json[0]["show"]["image"]["medium"].stringValue
            print(showDataModel.posterImage)
            showDataModel.showGenres = json[0]["show"]["genres"][0].stringValue
            print(showDataModel.showGenres)
            showDataModel.showName = json[0]["show"]["name"].stringValue
            print(showDataModel.showName)
            updateUserUI()
        }
    }
    
    
    func setImage(_ sender: Any, api:String) {
    
    if let url = URL(string:api ){
        do {
            let data = try Data(contentsOf: url)
            self.poster1.image = UIImage(data: data)
            
        }catch let err {
            print(" Error : \(err.localizedDescription)")
        }
    }
}

    
    
}
