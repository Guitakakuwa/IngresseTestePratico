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
    
    //Show 1
  
    @IBOutlet weak var dateCreated1: UITextView!
    @IBOutlet weak var rating1: UITextView!
    @IBOutlet weak var backgroundShow1: UIImageView!
    @IBOutlet weak var poster1: UIImageView!
    @IBOutlet weak var titulo1: UITextView!
    @IBOutlet weak var genero1: UITextView!
    @IBAction func buttonShow1(_ sender: Any) {
    }
    
    //Show 2
    @IBOutlet weak var dateCreated2: UITextView!
    @IBOutlet weak var rating2: UITextView!
    @IBOutlet weak var backgroundShow2: UITextView!
    @IBOutlet weak var poster2: UIImageView!
    @IBOutlet weak var titulo2: UITextView!
    @IBOutlet weak var genero2: UITextView!
    
    //Show 3
    @IBOutlet weak var dateCreated3: UITextView!
    @IBOutlet weak var rating3: UITextView!
    @IBOutlet weak var backgroundShow3: UIImageView!
    @IBOutlet weak var poster3: UIImageView!
    @IBOutlet weak var titulo3: UITextView!
    @IBOutlet weak var genero3: UITextView!
    
    //Show 4
    @IBOutlet weak var dateCreated4: UITextView!
    @IBOutlet weak var rating4: UITextView!
    @IBOutlet weak var backgroundShow4: UITextView!
    @IBOutlet weak var poster4: UIImageView!
    @IBOutlet weak var titulo4: UITextView!
    @IBOutlet weak var genero4: UITextView!
    
    //Import de Model
    let showDataModel = ShowDataModel()
    
    let api:String = "http://api.tvmaze.com/search/shows?q=girls"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAPI(url:api)
        setBorders()
        
    }
    
    func setBorders(){
        //Show 1
        genero1.layer.cornerRadius = 15
        backgroundShow1.layer.cornerRadius = 15
        
        //Show 2
        backgroundShow2.layer.cornerRadius = 15
        genero2.layer.cornerRadius = 15
        
        //Show 3
        backgroundShow3.layer.cornerRadius = 15
        genero3.layer.cornerRadius = 15
        
        //Show 4
        backgroundShow4.layer.cornerRadius = 15
        genero4.layer.cornerRadius = 15
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
    
    func updateUserUI(num : Int) {
        //Show 1
        if(num == 1){
            setImage(self, api: showDataModel.posterImage,poster: self.poster1)
        titulo1.text = showDataModel.showName
        genero1.text = showDataModel.showGenres
        dateCreated1.text = "Data de exibição: " + showDataModel.premieredDate
        rating1.text = "Nota: " + String(showDataModel.rating)
        }
        if (num == 2 ){
        //Show 2
            setImage(self, api: showDataModel.posterImage, poster: self.poster2)
        titulo2.text = showDataModel.showName
        genero2.text = showDataModel.showGenres
        dateCreated2.text = "Data de exibição: " + showDataModel.premieredDate
        rating2.text = "Nota: " + String(showDataModel.rating)
        }
        
        if (num == 3 ){
            //Show 3
            setImage(self, api: showDataModel.posterImage, poster: self.poster3)
            titulo3.text = showDataModel.showName
            genero3.text = showDataModel.showGenres
            dateCreated3.text = "Data de exibição: " + showDataModel.premieredDate
            rating3.text = "Nota: " + String(showDataModel.rating)
        }
        
        if (num == 4 ){
            //Show 4
            setImage(self, api: showDataModel.posterImage, poster: self.poster4)
            titulo4.text = showDataModel.showName
            genero4.text = showDataModel.showGenres
            dateCreated4.text = "Data de exibição: " + showDataModel.premieredDate
            rating4.text = "Nota: " + String(showDataModel.rating)
        }
    }
    
    func setInfoShows (json:JSON) {
        
        //Show 1
        if  let posterImage:String = json[0]["show"]["image"]["medium"].stringValue {
            showDataModel.posterImage =  json[0]["show"]["image"]["medium"].stringValue
            showDataModel.showGenres = json[0]["show"]["genres"][0].stringValue
            showDataModel.showName = json[0]["show"]["name"].stringValue
            showDataModel.rating = json[0]["show"]["rating"]["average"].doubleValue
            showDataModel.premieredDate = json[0]["show"]["premiered"].stringValue
            updateUserUI(num:1)
            
//        Show 2
            showDataModel.posterImage =  json[1]["show"]["image"]["medium"].stringValue
            showDataModel.showGenres = json[1]["show"]["genres"][0].stringValue
            showDataModel.showName = json[1]["show"]["name"].stringValue
            showDataModel.rating = json[1]["show"]["rating"]["average"].doubleValue
            showDataModel.premieredDate = json[1]["show"]["premiered"].stringValue
            updateUserUI(num:2)
            
//            Show 3
            showDataModel.posterImage =  json[5]["show"]["image"]["medium"].stringValue
            showDataModel.showGenres = json[5]["show"]["genres"][0].stringValue
            showDataModel.showName = json[5]["show"]["name"].stringValue
            showDataModel.rating = json[5]["show"]["rating"]["average"].doubleValue
            showDataModel.premieredDate = json[5]["show"]["premiered"].stringValue
            updateUserUI(num:3)
            
//            Show 4
            showDataModel.posterImage =  json[4]["show"]["image"]["medium"].stringValue
            showDataModel.showGenres = json[4]["show"]["genres"][0].stringValue
            showDataModel.showName = json[4]["show"]["name"].stringValue
            showDataModel.rating = json[4]["show"]["rating"]["average"].doubleValue
            showDataModel.premieredDate = json[4]["show"]["premiered"].stringValue
            updateUserUI(num:4)
        }
    }
    
    
    func setImage(_ sender: Any, api:String, poster:UIImageView) {
    
    if let url = URL(string:api){
        do {
            let data = try Data(contentsOf: url)
            poster.image = UIImage(data: data)
            
        }catch let err {
            print(" Error : \(err.localizedDescription)")
        }
    }
}

    
    
}
