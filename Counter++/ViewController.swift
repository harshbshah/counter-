//
//  ViewController.swift
//  Counter++
//
//  Created by Harsh Shah on 2017-10-26.
//  Copyright © 2017 Harsh Shah. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class ViewController: UIViewController {
    var temp:String = "--"
    @IBAction func decrement(_ sender: Any) {
        
    }
    @IBAction func plus(_ sender: Any) {
        let ntemp = Int(temp)! + 1
            temp = String(ntemp)
        print (temp)
                // prepare json data
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = ["c":temp
            
        ]
        
        Alamofire.request("http://localhost:3000/api/counter", method: .post, parameters: parameters, encoding:  URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case.success(let data):
                print("success",data)
            case.failure(let error):
                print("Not Success",error)
                print( "Server Error!!")
            }
            
        }
        
        
    sleep(2)
      lbl_counter.text = temp
//

        
    }
    @IBOutlet weak var lbl_counter: UILabel!
    @IBOutlet weak var minus: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLbl()
        sleep(3)
         lbl_counter.text = temp
        
    }

    func setLbl(){
        var request = URLRequest(url: URL(string: "http://localhost:3000/api/counter")!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) {data, response, error in
            let requestReply = NSString(data: data!, encoding: String.Encoding.ascii.rawValue)
            print("Request reply: \(requestReply!)")
            //   if let data = data.data(using: .utf8) {
            if let json = try? JSON(data: data!) {
                for item in json["Data"].arrayValue {
                    
                    self.temp = (item["c"].stringValue)
                }
            }
            
            
            }.resume()
       // onCompleted()
       
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //*** for get
//    var request = URLRequest(url: URL(string: "http://YourURL.com/FakeURL/PARAMETERS")!)
//    request.httpMethod = "GET"
//
//    let session = URLSession(configuration: .default)
//    session.dataTask(with: request) {data, response, error in
//    let requestReply = NSString(data: data!, encoding: String.Encoding.ascii.rawValue)
//    print("Request reply: \(requestReply!)")
//    }.resume()

    //**** for post
//    let post = "test=Message&this=isNotReal"
//    let postData = post.data(using: String.Encoding.ascii, allowLossyConversion: true)
//
//    let postLength = String(postData!.count)
//
//    var request = URLRequest(url: URL(string: "http://YourURL.com/FakeURL/PARAMETERS")!)
//    request.httpMethod = "POST"
//    request.addValue(postLength, forHTTPHeaderField: "Content-Length")
//    request.httpBody = postData;
//    // create post request
//    let url = URL(string: "http://localhost:3000/api/counter")!
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//
//    // insert json data to the request
//    request.addValue("c", forHTTPHeaderField: temp)
//    request.
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        guard let data = data, error == nil else {
//            print(error?.localizedDescription ?? "No data")
//            return
//        }
//        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//        if let responseJSON = responseJSON as? [String: Any] {
//            print(responseJSON)
//        }
//    }
//
//    task.resume()
}

