//
//  MQViewController.swift
//  ataglance
//
//  Created by y41 on 3/9/22.
//

import UIKit

class MQViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // initiate MQ db and mgr
        mqMgr = MotivationalQuotesMgr()
        quoteText.text = mqMgr?.nextQuote()
    }
    
    var mqMgr: MotivationalQuotesMgr?
    @IBOutlet var quoteText: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func pressNextQuote(_ sender: Any) {
        quoteText.text = mqMgr?.nextQuote()
    }
    
}
