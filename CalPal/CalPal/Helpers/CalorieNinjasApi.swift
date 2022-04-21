//
//  CalorieNinjasApi.swift
//  CalPal
//
//  Created by Arslan Alimov on 4/5/22.
//

import Foundation
//app.quicktype.io <= gives a class from json response
class ApiNinja{
struct Response: Codable {
    let items: [Item]
}

struct Item: Codable {
    
    var sugarG, fiberG, servingSizeG, sodiumMg: Double
    var name: String
    var potassiumMg, fatSaturatedG: Double
    var fatTotalG, calories: Double
    var cholesterolMg: Double
    var proteinG, carbohydratesTotalG: Double

    enum CodingKeys: String, CodingKey {
        case sugarG = "sugar_g"
        case fiberG = "fiber_g"
        case servingSizeG = "serving_size_g"
        case sodiumMg = "sodium_mg"
        case name
        case potassiumMg = "potassium_mg"
        case fatSaturatedG = "fat_saturated_g"
        case fatTotalG = "fat_total_g"
        case calories
        case cholesterolMg = "cholesterol_mg"
        case proteinG = "protein_g"
        case carbohydratesTotalG = "carbohydrates_total_g"
    }
}
}
class ApiCalorieNinja{
    //rewrote a function from calorieninja.com/api made it a function passing a string
    func LoadDataApi(searchQuery: String, isCompleted: @escaping (ApiNinja.Response) -> ()){
       
        let ApiUrl=URL(string:"https://api.calorieninjas.com/v1/nutrition?query=\(searchQuery)".replacingOccurrences(of: " ", with: "%20"))
        print("Making Request:")
        if let UrlRespUnwrap = ApiUrl {
            print("Creating Request:")
            //creating a request client
            var req = URLRequest(url: UrlRespUnwrap)
            //need X-Api-key header
            req.addValue("hKZHjqT0tboYODcASrSn7Q==GJKCCgSVG6t985Qn", forHTTPHeaderField: "X-Api-Key")
            //creating a task
            let threadFetch = URLSession.shared.dataTask(with: req){ (responseData, response, responseError) in
                print("Making Api Call")
                let responseData = try! JSONDecoder().decode(ApiNinja.Response.self, from: responseData!)
                DispatchQueue.main.async {
                                        isCompleted(responseData)
                                        print("Api Call returned" + "\(responseData)"  )
                   
            
                                    
                }
            }
            threadFetch.resume()
            
        }
    }
}

