//
//  ViewController.swift
//  JavaScriptCore Demo
//
//  Created by Joseph Slinker on 2/13/18.
//  Copyright © 2018 Lucidchart. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController {
	
	let context = JSContext()!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// A simple "Hello World" script
		var result = self.context.evaluateScript("var x = 'Hello world!';")!
		result = self.context.evaluateScript("x;")!
		print(result)
		
		
		
		// A more advanced example
		
		// Catch JavaScript exceptions
		self.context.exceptionHandler = { context, error in
			print(error!)
		}
		
		// Load our dependencies from disk
		if let path = Bundle.main.path(forResource: "demo", ofType: "js"),
			let demo = try? String(contentsOfFile: path),
			let depsPath = Bundle.main.path(forResource: "demoDeps", ofType: "js"),
			let demoDeps = try? String(contentsOfFile: depsPath),
			let promiseDepsPath = Bundle.main.path(forResource: "promiseDeps", ofType: "js"),
			let promiseDeps = try? String(contentsOfFile: promiseDepsPath) {
			
			// Make our native implementations of interval, timeout, and fetch available to the JSContext
			JSFetch.provideToContext(context: self.context, hostURL: "https://www.google.com")
			JSIntervals.provideToContext(context: self.context)
			
			// Load our JavaScript dependencies into the context (order matters)
			self.context.evaluateScript(demoDeps)
			self.context.evaluateScript(promiseDeps)
			self.context.evaluateScript(demo)
			
			// Convert a block into a JavaScript function
			let callback: @convention (block)(JSValue) -> () = { (content: JSValue) in
				print("Request result: \(content.toString())")
			}
			self.context.setObject(callback, forKeyedSubscript: "DemoCallback" as NSString)
			let jsCallback = self.context.objectForKeyedSubscript("DemoCallback")!
			
			// Call the function defined in `demo`
			let fetchURL = self.context.evaluateScript("fetchURL")!
			fetchURL.call(withArguments: ["https://www.google.com", jsCallback])
		}
	}

}

