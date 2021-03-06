//
//  SafariExtensionHandler.swift
//  ImageSearch Extension
//
//  Created by Rayer on 2019/12/14.
//  Copyright © 2019 Rayer. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func validateContextMenuItem(withCommand command: String, in page: SFSafariPage, userInfo: [String : Any]? = nil, validationHandler: @escaping (Bool, String?) -> Void) {
        
        if let imgUrl = userInfo?["imageSrc"] {
            NSLog("validateContextMenuItem : Entered validation area : \(imgUrl), type is \(type(of: imgUrl))")
            //let imgSrc = (imgUrl as! NSString).lastPathComponent
            validationHandler(false, nil)
        } else {
            NSLog("validateContextMenuItem : userInfo-imageSrc = \(String(describing: userInfo?["imageSrc"]))")
            validationHandler(true, nil)
        }
    }
    
    override func contextMenuItemSelected(withCommand command: String, in page: SFSafariPage, userInfo: [String : Any]? = nil) {
        NSLog("contextMenuItemSelected : Command : \(command), UserInfo : \(String(describing: userInfo))")
        guard let imgUrl = userInfo?["imageSrc"] as? String else {
            return
        }
        
        let cmdMap : [String:SearchProvider] = ["GoogleImageSearch": .Google, "BingImageSearch": .Bing, "YandexImageSearch": .Yandex]
        
        let searchUrl = GenerateISUrl(fromProvider: cmdMap[command] ?? .Google, withImgUrl: imgUrl)
        
        SFSafariApplication.getActiveWindow { (activeWindow) in
            activeWindow?.openTab(with: URL(string: searchUrl)!, makeActiveIfPossible: true, completionHandler: nil)
        }
        
        
        if command == "GoogleImageSearch" {
            let googleSearchUrl = "https://www.google.com/searchbyimage?&image_url=\(imgUrl)&safe=off";
            SFSafariApplication.getActiveWindow { (activeWindow) in
                activeWindow?.openTab(with: URL(string: googleSearchUrl)!, makeActiveIfPossible: true, completionHandler: {_ in
                    NSLog("Opened google image search url : \(googleSearchUrl)")
                })
            }
        }
        
        if command == "CopyToClipboard" {
            let url = URL(string: imgUrl)
            NSLog("imgUrl is : \(imgUrl)")
            NSLog("Attempting loading from url : \(String(describing: url?.absoluteString))")
            guard let u = url else {
                return
            }
            let data = try? Data(contentsOf: u)
            let image = NSImage(data: data!)
            
            let pb = NSPasteboard.general
            
            pb.clearContents()
            let success = pb.writeObjects([image! as NSImage])
            if !success {
                NSLog("Fail to write into pasteboard!")
            }
        }
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
