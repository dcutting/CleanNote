//
//  AppDelegate.swift
//  CleanNoteMac
//
//  Created by Dan Cutting on 27/07/2016.
//  Copyright © 2016 cutting.io. All rights reserved.
//

import Cocoa
import CleanNoteCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application

    _ = Note(id: "one", text: "ok")
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


}

