//
//  AppDelegate.swift
//  AppX
//
//  Created by Pranay Kumar on 04/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var splashTimer:NSTimer?
    var storyboard:UIStoryboard?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let launchScreen = getView(storyboardName: "LaunchScreen", storyboardIdentifier: "LaunchScr").view
        
        window?.makeKeyAndVisible()
        window?.addSubview(launchScreen)
        window?.bringSubviewToFront(launchScreen)
        
        let loginController = getView(storyboardName: "Login", storyboardIdentifier: "LoginView") as! LoginViewController
        
        window?.rootViewController?.presentViewController(loginController, animated: false, completion:{
            
            loginController.status = LoginViewStatus.signingIn
            
            UIView.animateWithDuration(1, animations: {launchScreen.alpha=0}, completion: { (Bool) -> Void  in launchScreen.removeFromSuperview();
            
                do{
                    let user = try loginUsingStoredCredentials()
                    if user != nil{
                        loginController.dismissViewControllerAnimated(false, completion: nil)
                    }
                    else{
                        loginController.status = LoginViewStatus.loginView
                        loginController.displayLoginScreen()
                    }
                }catch UnauthorizedUser.invalidCredentials{
                    
                    let okAction = UIAlertAction(title: Constants.OK, style: .Cancel, handler: {(alert: UIAlertAction!) in loginController.status = LoginViewStatus.loginView})
                    showAlert(ErrorMessages.EXPIRED_CREDENTIALS_TITLE, message: ErrorMessages.EXPIRED_CREDENTIALS_MESSAGE, currentView: loginController, actions: okAction)
                    loginController.status = LoginViewStatus.loginView
                } catch let error as NSError{
                    print("error: \(error)")
                }

                
            return
                
            })
        })
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

