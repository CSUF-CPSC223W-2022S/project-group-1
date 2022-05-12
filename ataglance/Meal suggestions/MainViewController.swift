//
//  MainViewController.swift
//  ataglance
//
//  Created by Brian Escobar on 5/11/22.
//

import UIKit

// Main Application View
class ViewController: UIViewController {
    // Outlets connected to the interface
    
    @IBOutlet var MealNameLabel: UILabel!
    @IBOutlet var IngredientInput: UITextField!
    @IBOutlet var MealImage: UIImageView!
    @IBOutlet var MealLabelThree: UILabel!
    @IBOutlet var MealLabelTwo: UILabel!
    @IBOutlet var MealImageTwo: UIImageView!
    @IBOutlet var MealImageThree: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealNameLabel.text = ""
        MealLabelTwo.text = ""
        MealLabelThree.text = ""
    }

    @IBAction func pressUpdate(_ sender: Any) {
        let IngredientText: String? = IngredientInput.text

        // Initiate interface update.
        updateInterface(Ingredient: IngredientText)
    }
    
    // Updates the interface using data retrieved from a meal API
    func updateInterface(Ingredient: String?) {
        let mInfo = MealController()
        mInfo.fetchMealInfo(Ingredient: Ingredient) { info in
            /* Run code block on the main thread so the application continues to
               run (asynchronously) while waiting for the block to complete.
             */

            DispatchQueue.main.async {
                // Verify that Meal information is available
                guard let mealInfo = info else { return }
                // Populate interface with the meal name

                self.MealNameLabel.text = mealInfo.meals[0].mealName
                let mealUrl = URL(string: mealInfo.meals[0].mealUrl)!
                
                if mealInfo.meals.count >= 2 {
                    self.MealLabelTwo.text = mealInfo.meals[1].mealName
                    let mealUrl2 = URL(string: mealInfo.meals[1].mealUrl)!
                    mInfo.fetchImage(url: mealUrl2) {
                        imagein
                        /* Run the code on the main thread so the application continues to
                           run while waiting for the code block to complete.
                         */
                        DispatchQueue.main.async {
                            /* Verify the image data is available and it's format can be used
                               to create an image.
                             */
                            guard let theImage = image else { return }
                            // Update image on the interface if available
                            self.MealImageTwo.image = theImage
                        }
                    }
                }
                if mealInfo.meals.count >= 3 {
                    self.MealLabelThree.text = mealInfo.meals[2].mealName
                    let mealUrl3 = URL(string: mealInfo.meals[2].mealUrl)!
                    mInfo.fetchImage(url: mealUrl3) {
                        imagein
                        /* Run the code on the main thread so the application continues to
                           run while waiting for the code block to complete.
                         */
                        DispatchQueue.main.async {
                            /* Verify the image data is available and it's format can be used
                               to create an image.
                             */
                            guard let theImage = image else { return }
                            // Update image on the interface if available
                            self.MealImageThree.image = theImage
                        }
                    }
                }
                
                // Load photo of the meal using the url returned by the server
                mInfo.fetchImage(url: mealUrl) {
                    imagein
                    /* Run the code on the main thread so the application continues to
                       run while waiting for the code block to complete.
                     */
                    DispatchQueue.main.async {
                        /* Verify the image data is available and it's format can be used
                           to create an image.
                         */
                        guard let theImage = image else { return }
                        // Update image on the interface if available
                        self.MealImage.image = theImage
                    }
                }
            }
        }
    }
}
