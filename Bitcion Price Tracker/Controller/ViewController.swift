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
    
    var currencySymbol:String = ""
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    let bitCoinDataModel = BitCoinDataModel()
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
        let currencyNameArray = ["Australian Dollar", "Brazilian Real","Canadian Dollar","Chinese Yuan","Euro","Pound Sterling","Hong Kong Dollar","Indonesian Rupiah","Israeli New Shekel","Indian Rupee","Japanese Yen","Mexican Peso","Norwegian Krone","New Zealand Dollar","Poland Złoty","Romanian Leu","Russian Ruble","Swedish Krona","Singapore Dollar","United States Dollar","South African Rand"]
    
    
        let currencySymbolArray = ["A$", "R$","C$","¥","€","£","HK$","Rp","₪","₹","¥","Mex$","kr","$","zł","lei","₽","kr","S$","$","R"]
    
    var finalURL = ""
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Very important peiece of code where we are registering our class as delegate and data source for this currency picker. And also remeber to add the binding for picker data source and delegate as ViewController. Without this also it will work, but on safer side provide the same.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        // on load UI should show data related to first item of the picker, below changes are done for the same.
        finalURL = baseURL + currencyArray[0]
        currencySymbol = currencySymbolArray[0]
        priceLabelOutlet.text = "Loading..."
        getBitCoinData(url: finalURL)
    }
    
    
    //MARK: - Picker Data Source methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return currencyNameArray.count
    }

    //MARK: - Picker Delegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return currencyNameArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        finalURL = baseURL + currencyArray[row]
        currencySymbol = currencySymbolArray[row]
        print(finalURL)
        priceLabelOutlet.text = "Loading..."
        getBitCoinData(url: finalURL)
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    func getBitCoinData(url:String)
    {
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { response in
            
            if(response.result.isSuccess)
            {
                print("We are Succcessfully able to call the bitcoin service.")
                
                let bitCoinJSON :JSON = JSON(response.result.value!)
                
                print(bitCoinJSON)
                self.updateBitCoinData(jsonValue: bitCoinJSON)
                
            }
            
            if (response.result.isFailure)
            {
                print("Its a failure to call the bitcoin URL \(String(describing: response.result.error))")
                self.priceLabelOutlet.text = "Connection Error"
            }
        }
        
    }
    

    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateBitCoinData(jsonValue:JSON)
    {
        // below Optional wrapping is required to avoid app crashing incase we get error code from the api call
        if let bitCoinPrice = jsonValue["last"].double
        {
            bitCoinDataModel.bitCoinPrice = bitCoinPrice
            // below method will update all UI labels and image views
            updateUIWithBitCoinData()
        }
        else
        {
            priceLabelOutlet.text = "Price Value Unavailable"
            
        }
        
    }
    
    //MARK: - UI Updates
    /***************************************************************/
    
    func updateUIWithBitCoinData()
    {
        priceLabelOutlet.text = "\(currencySymbol)\(String(bitCoinDataModel.bitCoinPrice))"

    }

}

