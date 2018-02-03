import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserDefaults.standard.bool(forKey: "launchedBefore")  {
            firstLaunch()
        }
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                print(request)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func firstLaunch() {
        print("First Launch")
        authorize()
        createNotifications()
        UserDefaults.standard.set(true, forKey: "launchedBefore")
    }
    
    func authorize() {
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (granted, error) in
            print("Permission Granted!")
        }
    }
    
    func createNotifications() {
        
        let content = UNMutableNotificationContent()
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        content.title = NSString.localizedUserNotificationString(forKey: "Drik et glas vand.", arguments: nil)
        
        for day in 2...6 {
            for hour in 9...14 {
                var date = DateComponents()
                date.weekday = day
                date.hour = hour
                date.minute = 0
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: "DAY" + String(day) + "HOUR" + String(hour), content: content, trigger: trigger)
                center.add(request) { (error: Error?) in
                    if let theError = error {
                        print(theError.localizedDescription)
                    }
                }
            }
        }
    }
}
