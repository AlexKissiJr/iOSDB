//
//  TableViewController.swift
//  iOSDB
//
//  Created by Alexander Kissi Jr on 7/8/19.
//  Copyright © 2019 Createlex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class TableViewController: UITableViewController, UISearchResultsUpdating {
   
     @IBOutlet weak var moveImage: UIImageView!
    private let apiFetcher = APIRequestFetcher()
    private var previousRun = Date()
    private let minInterval = 0.05

    
    private var searchResults = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }

    private let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        setupSearchBar()
        
    }
    
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search any Topic"
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // return the number of rows
    
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // return the number of rows

        
        
       return  self.searchResults.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = searchResults[indexPath.row]["title"].stringValue
        
        
        guard let poster_path_url = URL(string: "https://image.tmdb.org/t/p/w500\(searchResults[indexPath.row]["poster_path"])") else {
            print("the url image is null")
            return cell
        }
        
        
        
        apiFetcher.fetchImage(url: poster_path_url.absoluteString) { image, _ in
            self.moveImage.image = image
            cell.imageView?.image = image

        }
      
        return cell
    }
 
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        

//        Alamofire.request("https://api.themoviedb.org/3/search/movie?api_key=f07a0bf04ea8fe45f42e40abffc6770a&language=en-US&query=\(searchController.searchBar.text!)&page=1&include_adult=false").responseJSON { response in
////            print("Request: \(String(describing: response.request))")   // original url request
////            print("Response: \(String(describing: response.response))") // http url response
////            print("Result: \(response.result)")                         // response serialization result
//////
//
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//              //  print("Data: \(utf8Text)") // original server data as UTF8 string
//
//
//
//                let json = try? JSONSerialization.jsonObject(with: data, options: [])
//
//                if let dictionary = json as? [String: Any] {
//                    if let resultsA = dictionary["results"] as? [[String:Any]] {
//                        // access individual value in dictionary
//
//                        if (resultsA.isEmpty){
//
//                        } else {
//                           // print(resultsA[0]["original_title"])
//                            let original_title =  resultsA[0]["original_title"] as! String
//
//                            guard let poster_path_url = URL(string: "https://image.tmdb.org/t/p/w500\(resultsA[0]["poster_path"]!)") else {
//                                print("the url image is null")
//                                return
//                            }
//                            do
//                            {
//
//                            //    print(poster_path_url)
//                                let poster_path_data = try Data(contentsOf: poster_path_url)
//                                let poster_path_Image = UIImage(data: poster_path_data)
//                                tableDataImage.append(poster_path_Image!)
//
//
//                            }
//                            catch {
//
//                            }
//
//
//
//                          //  words.append(alexMe)
//
//                           // print("https://image.tmdb.org/t/p/w500\(resultsA[0]["poster_path"] ?? "none")")
//
//
//
//                           // self.tableDataImage.append(poster_path)
//                            tableData.append(original_title)
//
//
//                        }
//
//
//                    }
//
//
//                    for (key, value) in dictionary {
//                        // access all key / value pairs in dictionary
//                      //  print(value)
//
//                    }
//
//
//                }
//
//
//
//
//            }
//
//
        

            
            
            //tableData = NSMutableArray(
       // }
//
//
//
//        //tableData = words
//
//
//        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
//        let array = (tableData as NSArray).filtered(using: searchPredicate)
//        filteredTableData = array as! [String]
//
//
//        tableData = Array(Set(tableData))
//        tableDataImage = Array(Set(tableDataImage))
//        tableView.reloadData()
//
//
    
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // tableView.reloadData()
        
        
        guard let poster_path_url = URL(string: "https://image.tmdb.org/t/p/w500\(searchResults[indexPath.row]["poster_path"])") else {
            print("the url image is null")
            return
        }
        
        mainMoiveSummary = searchResults[indexPath.row]["overview"].stringValue
        
        mainMoiveTitleInfo = searchResults[indexPath.row]["title"].stringValue
        
        
      //  mainMoiveSummary = searchResults[indexPath.row]["overview"].s
        //  print(searchResults[indexPath.row]["poster_path"].stringValue)
        
        apiFetcher.fetchImage(url: poster_path_url.absoluteString) { image, _ in
            self.moveImage.image = image
            mainImage = image
            
            
            
        }
        

        tableView.reloadData()
        
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
    }
    

}

extension TableViewController: UISearchBarDelegate {
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }
        
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchResults(for: textToSearch)
        }
    }
    
    
    func fetchResults(for text: String) {
        print("Text Searched: \(text)")
        apiFetcher.search(searchText: text, completionHandler: {
            [weak self] results, error in
            if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            
            self?.searchResults = results
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults.removeAll()
    }
}
