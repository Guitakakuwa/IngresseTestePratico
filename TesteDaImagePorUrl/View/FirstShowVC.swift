//
//  FirstShowVC.swift
//  EntregaProjeto
//
//  Created by Guilherme Takakuwa on 3/14/19.
//  Copyright © 2019 Guilherme Takakuwa. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON



class FirstShowVC:UIViewController {
    
    @IBOutlet weak var dateCreated: UITextView!
    @IBOutlet weak var rating: UITextView!
    @IBOutlet weak var backgroundShow: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titulo: UITextView!
    @IBOutlet weak var genero: UITextView!
    @IBOutlet weak var descricao: UITextView!
    
    //Import de Model
    let showDataModel = ShowDataModel()
    
   
    let api:String = "http://api.tvmaze.com/search/shows?q=girls"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAPI(url:api)
     
        
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
            titulo.text = showDataModel.showName
            genero.text = showDataModel.showGenres
            dateCreated.text = "Data de exibição: " + showDataModel.premieredDate
            rating.text = "Nota: " + String(showDataModel.rating)
            descricao.text = showDataModel.descricao
        
    }
    
    func setInfoShows (json:JSON) {
        
        //Show 1
        if  let posterImage:String = json[0]["show"]["image"]["medium"].stringValue {
            showDataModel.posterImage =  json[0]["show"]["image"]["medium"].stringValue
            showDataModel.showGenres = json[0]["show"]["genres"][0].stringValue
            showDataModel.showName = json[0]["show"]["name"].stringValue
            showDataModel.rating = json[0]["show"]["rating"]["average"].doubleValue
            showDataModel.premieredDate = json[0]["show"]["premiered"].stringValue
            showDataModel.descricao = json[0]["show"]["summary"].stringValue
            var text = json[0]["show"]["summary"].stringValue
            text = text.replacingOccurrences(of: "<p>", with: "")
            text = text.replacingOccurrences(of: "</p>", with: "")
            showDataModel.descricao = text

            updateUserUI()
        }
    }
        
    func setImage(_ sender: Any, api:String) {
        
        if let url = URL(string:api){
            do {
                let data = try Data(contentsOf: url)
                self.poster.image = UIImage(data: data)
                
            }catch let err {
                print(" Error : \(err.localizedDescription)")
            }
        }
    }
    
}
