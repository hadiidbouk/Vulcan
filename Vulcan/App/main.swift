//
//  main.swift
//  Vulcan
//
//  Created by Hadi Dbouk on 10/07/2022.
//

import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
