//
//  MealViewController.swift
//  ataglance
//
//  Created by Brian Escobar on 5/11/22.
//

import Foundation
import UIKit

class MealController {
    func fetchMealInfo(Ingredient: String?, completion: @escaping (Meals?)->Void) {
        // URL of the Meal API excluding the query
        let baseURL = URL(string: "www.themealdb.com/api/json/v1/1/filter.php")!
        
        // Add the ingredient name to the query
        let query: [String: String] = ["i": Ingredient!]
        
        // Verify that the queries are valid and the URL is converted to the HTTPS scheme.
        guard let url = baseURL.withQueries(query), let secureURL = url.withHTTPS() else {
            return
        }
        
        // Create a request to retrieve data from the meal API. The closure is called
        // once the server replies to the request.
        let task = URLSession.shared.dataTask(with: secureURL) {
            data, _, _ in
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let photoInfo = try? jsonDecoder.decode(Meals.self, from: data)
            {
                // Call the closure and pass the constructed PhotoInfo object.
                completion(photoInfo)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                // Call the closure and pass nil when data cannot be retrieved or decoded.
                completion(nil)
            }
        }
        // Send the request
        task.resume()
    }
    
    // Create a UIImage object from a URL
    // - Parameters:
    ///  - url: url of the image
    //  - completion: closure is called and passed the nullable UIImage after getting the server repl
    func fetchImage(url: URL, completion: @escaping (UIImage?)->Void) {
        // Create a request to retrieve an image from the Meal API using the
        // photo URL.
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in
            /* Verify the image data is available and it can be used
               to create an image.
             */
            guard let imageData = data,
                  let image = UIImage(data: imageData)
            else {
                // Call the completion closure and pass nil if data can not be loaded
                completion(nil)
                return
            }
            // Call the completion closure and pass the UIImage object if it is available
            completion(image)
        }
        // Send the request
        task.resume()
    }
}
