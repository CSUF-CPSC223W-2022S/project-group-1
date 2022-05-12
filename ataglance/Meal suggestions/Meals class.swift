//
//  Meals class.swift
//  ataglance
//
//  Created by Brian Escobar on 5/11/22.
//

import Foundation

struct Meals: Codable {
    var meals: [MealInfo]
    
    // Initialize a PhotoInfo object's properties using data that is decoded by a decoder. In this case, a JSON decoder.
    
    init(from decoder: Decoder) throws {
        /* We assign our enumeration as the decoder's container.
         We use decode to extract one element from the
         JSON-formatted string and store it in the appropriate
         property. */
        let valueContainer = try decoder.container(keyedBy:
            CodingKeys.self)
        self.meals = try valueContainer.decode([MealInfo].self,
                                               forKey: CodingKeys.meals)
    }
}

struct MealInfo: Codable {
    // Each property will contain the corresponding value from the JSON file
    var mealName: String
    var mealUrl: String
    
    // We use an enumeration whose cases correspond to each property
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealUrl = "strMealThumb"
    }
}
