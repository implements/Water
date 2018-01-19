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
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Startup")
        } else {
            print("First Launch")
            authorize()
            createNotifications()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
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
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        content.title = NSString.localizedUserNotificationString(forKey: "Drik et glas vand.", arguments: nil)
        //content.body = NSString.localizedUserNotificationString(forKey: "Nu!", arguments: nil)
        
        for day in 2...6 {
            for hourUnit in 9...14 {
                var date = DateComponents()
                date.weekday = day;
                date.hour = hourUnit
                date.minute = 00
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: String(day + hourUnit), content: content, trigger: trigger)
                center.add(request) { (error: Error?) in
                    if let theError = error {
                        print(theError.localizedDescription)
                    }
                }
            }
        }
    }
}
