//
//  ViewController.swift
//  Bitcion Price Tracker
//
//  Created by Vikas R S on 8/8/18.
//  Copyright © 2018 Vikas Radhakrishna Shetty. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource
{
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var priceLabelOutlet: UILabel!
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Very important peiece of code where we are registering our class as delegate and data source for this currency picker.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    
    //MARK: - Picker Data Source methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return currencyArray.count
    }

    //MARK: - Picker Delegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    

    
    //MARK: - JSON Parsing
    /***************************************************************/


}

