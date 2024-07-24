import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyA70Jo_kDefZFcSJ1irQ9-V8KFC_sadZ1Y")
    GeneratedPluginRegistrant.register(with: self) 
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
