//
//  ViewController.swift
//  NoBetaBuild
//
//  Created by Jonny Kuang on 7/18/19.
//  Copyright © 2019 Jonny Kuang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let buildVersionKey = "buildVersion"
    
    /// macOS Mojave 10.14.5
    let defaultBuildVersion = "18F203"
    
    @IBOutlet var textField: NSTextField! {
        didSet {
            let version = validate(UserDefaults.standard.string(forKey: buildVersionKey))
            UserDefaults.standard.setValue(version, forKey: buildVersionKey)
        }
    }
    
    @IBAction func openDocument(_ sender: Any) {
        UserDefaults.standard.set(validate(textField.stringValue), forKey: buildVersionKey)
        
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.allowedFileTypes = ["xcarchive"]
        
        panel.beginSheetModal(for: view.window!) { result in
            guard result == .OK else {
                return
            }
            DispatchQueue.global(qos: .userInitiated).async {
                self.handle(panel.urls)
            }
        }
    }
    
    func handle(_ fileURLs: [URL]) {
        let buildVersion = validate(UserDefaults.standard.string(forKey: buildVersionKey))
        
        for url in fileURLs {
            guard let subpaths = FileManager.default.subpaths(atPath: url.path) else { continue }
            let infoPlistPaths = subpaths.filter { $0.hasSuffix("/Info.plist") }
            
            for path in infoPlistPaths {
                let plistURL = url.appendingPathComponent(path, isDirectory: false)
                
                if let dictionary = NSMutableDictionary(contentsOf: plistURL), dictionary["BuildMachineOSBuild"] != nil {
                    dictionary["BuildMachineOSBuild"] = buildVersion
                    let success = dictionary.write(to: plistURL, atomically: true)
                    print(success)
                }
            }
        }
    }
    
    func validate(_ buildVersion: String?) -> String {
        let string = (buildVersion ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        return string.isEmpty ? defaultBuildVersion : string
    }
}

