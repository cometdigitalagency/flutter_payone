import Flutter
import UIKit
import payone

public class SwiftFlutterPayonePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_payone", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPayonePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
   switch call.method {
      case "initStore":
          do {
            let storeData = call.arguments
              result(self.initStore(storeData: storeData as![String: String]))
          }
      case "buildqrcode":
          do{
            let transectionData = call.arguments
           result(self.buildQrcode(qrData: transectionData as![String: String]))
          }
      case "observe":
          do {
              POManager.shared.start();
              POManager.shared.onReceivedMessage = { message in
                  let subscription = message.data.subscription
                  print("\(message.data.publisher) sent message to '\(message.data.channel)' at \(message.data.timetoken): \(message.data.message)")
                  
                  DispatchQueue.main.async {
                      result(message.data.message)
                  }
              }
          }
    
      default:
             result("bad")
      }
  }
    private func initStore(storeData: [String: String])->String{
           POManager.shared.initStore(mcid: storeData["mcid"]!, country: storeData["country"]!, province: storeData["province"]!, subscribeKey: storeData["subscribeKey"]!, terminalid: storeData["terminalid"]!, iin: storeData["iin"]!, applicationid: storeData["applicationid"]!)
             return "initialized store"
       }
       
       private func buildQrcode(qrData:[String:String])->String{
        let amount = Int(qrData["amount"]!)
           return POManager.shared.buildQrcode(amount: amount!, currency: qrData["currency"]!, invoiceid: qrData["invoiceid"]!, description: qrData["description"]!)
       }

}
