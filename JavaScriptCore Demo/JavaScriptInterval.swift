//
//  JavaScriptInterval.swift
//  Lucidchart
//
//  Created by Joseph Slinker on 1/23/18.
//  Copyright © 2018 Lucid Software. All rights reserved.
//

import Foundation
import JavaScriptCore

class JSIntervals: NSObject {
	
	private static var intervals: [Int: Timer] = [:]
	
	class func provideToContext(context: JSContext) {
		let setInterval: @convention(block) (Any) -> (Int) = { (any: Any) in
			return self.setInterval(context: JSContext.current(), repeats: true, args: JSContext.currentArguments() as! [JavaScriptCore.JSValue])
		}
		context.setObject(setInterval, forKeyedSubscript: "setInterval" as NSString)

		let setTimeout: @convention(block) (Any) -> (Int) = { (any: Any) in
			return self.setInterval(context: JSContext.current(), repeats: false, args: JSContext.currentArguments() as! [JavaScriptCore.JSValue])
		}
		context.setObject(setTimeout, forKeyedSubscript: "setTimeout" as NSString)

		let clearInterval: @convention(block) (JavaScriptCore.JSValue) -> () = { (value: JavaScriptCore.JSValue) in
			self.clearInterval(context: JSContext.current(), tag: Int(value.toInt32()))
		}
		context.setObject(clearInterval, forKeyedSubscript: "clearInterval" as NSString)
		context.setObject(clearInterval, forKeyedSubscript: "clearTimeout" as NSString)
	}
	
	private class func setInterval(context: JSContext, repeats: Bool, args: [JavaScriptCore.JSValue]) -> Int {
		var args = args
		let function = args.removeFirst()
		let interval = args.removeFirst().toDouble() / 1000
		let tag = UUID().hashValue
		
		let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) { (timer) in
			function.call(withArguments: args)
		}
		self.intervals[tag] = timer
		return tag
	}
	
	private class func clearInterval(context: JSContext, tag: Int) {
		self.intervals[tag]?.invalidate()
		self.intervals[tag] = nil
	}
	
}
