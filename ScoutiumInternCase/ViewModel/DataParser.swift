//
//  DataParser.swift
//  ScoutiumInternCase
//
//  Created by Huseyn Valiyev on 13.12.2020.
//

import Foundation
import Alamofire

class DataParser {
    
    var isLoading = true
    
    func parseData(comp: @escaping (([DataStruct]) ->())){
        let url = "https://storage.googleapis.com/anvato-sample-dataset-nl-au-s1/life-1/data.json"
        AF.request(url).responseData { response in
            let data = response.data
            do{
                let result = try JSONDecoder().decode(DataModel.self, from: data!)
                comp(result.items)
                self.isLoading = false
            }catch{
                print("Error happening parse data \(error)")
            }
        }
    }
    
}
