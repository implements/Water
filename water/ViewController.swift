//
//  ViewController.swift
//  water
//
//  Created by Thoai-Lam Nguyen on 18/01/2018.
//  Copyright © 2018 Thoai-Lam Nguyen. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        authorize()
        createNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authorize() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: .alert) { (granted, error) in
            print("Permission Granted!")
        }
    }
    
    func createNotifications() {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Drink Water!", arguments: nil)
        //content.body = NSString.localizedUserNotificationString(forKey: "Nu!", arguments: nil)
        
        for index in 9...14 {
            var date = DateComponents()
            date.hour = index
            date.minute = 00
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(identifier: String(index), content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error: Error?) in
                if let theError = error {
                    print(theError.localizedDescription)
                }
            }
        }
    }
}
