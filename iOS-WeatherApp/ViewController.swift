//
//  ViewController.swift
//  iOS-WeatherApp
//
//  Created by FENG-HSIANG Chien on 2014/8/5.
//  Copyright (c) 2014年 FENG-HSIANG Chien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    let urlPath: String = "http://api.openweathermap.org/data/2.5/weather?q=Taipei"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getWeather()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeather() {
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            
            if (error) {
                println("Cannot get weather information from server.")
                return
            }
            
            // Parsing JSON
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            
            // Display
            let temp : AnyObject? = jsonResult["main"]?["temp"]
            self.temperatureLabel.text = "\(Int(round(temp!.floatValue - 273.15)))℃"
            
            let weather : AnyObject? = jsonResult["weather"]?[0]!["description"]
            self.weatherLabel.text = "\(weather!)"
            
            println(jsonResult)
        }
    }

}

