//
//  PushNotificationManager.swift
//  Model
//
//  Created by Andreas on 6/9/21.
//

//import Firebase
//import FirebaseMessaging
//import UIKit
//import UserNotifications
//import SwiftUI
//
//class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
//   
//    @ObservedObject var userData: UserData
//     init(userData: UserData) {
//        self.userData = userData
//      
//    }
//
//    func registerForPushNotifications() {
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//            // For iOS 10 data message (sent via FCM)
//            Messaging.messaging().delegate = self
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(settings)
//        }
//
//        UIApplication.shared.registerForRemoteNotifications()
//        updateFirestorePushTokenIfNeeded()
//    }
//
//    func updateFirestorePushTokenIfNeeded() {
//        if let token = Messaging.messaging().fcmToken {
////            let usersRef = Firestore.firestore().collection("users_table").document(userID)
////            usersRef.setData(["fcmToken": token], merge: true)
//            userData.fcm = token
//        }
//    }
//
//  
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print(response)
//    }
//}
