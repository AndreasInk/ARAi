//
//  PushNotificationSender.swift
//  Model
//
//  Created by Andreas on 6/9/21.
//

//import UIKit
//
//class PushNotificationSender {
//    func sendPushNotification(to token: String, title: String, body: String) {
//        let urlString = "https://fcm.googleapis.com/fcm/send"
//        let url = NSURL(string: urlString)!
//        let paramString: [String : Any] = ["to" : token,
//                                           "notification" : ["title" : title, "body" : body],
//                                           "data" : ["user" : "test_id"]
//        ]
//
//        let request = NSMutableURLRequest(url: url as URL)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("key=AAAACeF8bPE:APA91bGBqBUoby8pZkYwl25ag6febewfZR8-wRrVPhYArwOjW5vg19N56Fong4hQZz_A-1lWL2FVriLzMh7dMOR36caoUuhdChdFf7n3ldEHOTTS_Q-ztRKNMdeida-fRRa17XSh8j9Y", forHTTPHeaderField: "Authorization")
//
//        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
//            do {
//                if let jsonData = data {
//                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
//                        NSLog("Received data:\n\(jsonDataDict))")
//                    }
//                }
//            } catch let err as NSError {
//                print(err.debugDescription)
//            }
//        }
//        task.resume()
//    }
//}
