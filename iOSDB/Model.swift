//
//  Model.swift
//  iOSDB
//
//  Created by Alexander Kissi Jr on 7/8/19.
//  Copyright © 2019 Createlex. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

var tableData = [""]
var tableDataImage = [UIImage()]
var mainImage:UIImage?
var mainMoiveSummary:String?
var mainMoiveTitleInfo:String?

var resultSearchController = UISearchController()

enum NetworkError: Error {
    case failure
    case success
}


class APIRequestFetcher {
    var searchResults = [JSON]()
    
    func search(searchText: String, completionHandler: @escaping ([JSON]?, NetworkError) -> ()) {
        let urlToSearch = "https://api.themoviedb.org/3/search/movie?api_key=f07a0bf04ea8fe45f42e40abffc6770a&language=en-US&query=\(searchText)&page=1&include_adult=false"
        
        Alamofire.request(urlToSearch).responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                return
            }
            
            let json = try? JSON(data: data)
            //let results = json?["query"]["pages"].arrayValue
            let results = json?["results"].arrayValue

            guard let empty = results?.isEmpty, !empty else {
                completionHandler(nil, .failure)
                return
            }
            
            completionHandler(results, .success)
        }
    }
    
    func fetchImage(url: String, completionHandler: @escaping (UIImage?, NetworkError) -> ()) {
        Alamofire.request(url).responseData { responseData in
            
            guard let imageData = responseData.data else {
                completionHandler(nil, .failure)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completionHandler(nil, .failure)
                return
            }
            
            completionHandler(image, .success)
        }
    }
}
