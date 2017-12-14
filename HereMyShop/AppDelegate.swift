//
//  AppDelegate.swift
//  HereMyShop
//
//  Created by admin on 13/12/2017.
//  Copyright © 2017 MuhammadAamir. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import GoogleMaps


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var APIKey = "AIzaSyD_fLRJIP_9Oo7S1cvMvIAuVtv5c22H9uY"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //GoogleMap Project Configuration Here Only for Map Services
        GMSServices.provideAPIKey(APIKey)
        
        //GoogleMap Places Services Configuration here if Needed
//        GMSPlacesClient.provideAPIKey(APIKey)
        
        //Firebase Project Configuration here...
        FirebaseApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HereMyShop")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

