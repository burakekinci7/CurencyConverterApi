//
//  ViewController.swift
//  CurencyConverterApi
//
//  Created by Ramazan Burak Ekinci on 13.11.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadText: UILabel!
    @IBOutlet weak var chfText: UILabel!
    @IBOutlet weak var gbpText: UILabel!
    @IBOutlet weak var jpyText: UILabel!
    @IBOutlet weak var usdText: UILabel!
    @IBOutlet weak var tryText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //http icin (for http request): Go to info.plist. add to App transport security settings
    @IBAction func getRetesClick(_ sender: Any) {
        
        // 1- Request & Session
        // 2- Responce & Data
        // 3- Parsing & Json Serialization (Serializable)
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=d6c4d52ef6fca87ed458e63a11cefce9")
        let session = URLSession.shared
        //clouser
        let task = session.dataTask(with: url!) { data, responce, error in
            if error != nil {
                //if return error in task
                let alert = UIAlertController(title: "Eroor", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okeyButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okeyButton)
                self.present(alert, animated: true,completion: nil)
            }else{
                if data != nil  {
                    // if return is data
                    do{
                        let jsonResponce = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String ,Any>
                        //theread. asyncron process
                        DispatchQueue.main.async {
                            //print(jsonResponce)
                            if let rates = jsonResponce["rates"] as? [String : Any]{
                                //converter
                                if let cad = rates["CAD"] as? Double{
                                    self.cadText.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfText.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpText.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyText.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdText.text = "USD: \(usd)"
                                }
                                if let turkish = rates["TRY"] as? Double{
                                    self.tryText.text = "TRY: \(turkish)"
                                }
                            }
                        }
                    } catch{
                        print("Eroor. Not responce")
                    }
                }
            }
        }
        task.resume()
    }
}
