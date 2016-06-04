//
//  XCTestCase.swift
//  carrefour
//
//  Created by Douglas Barreto on 4/20/16.
//  Copyright © 2016 Edouard Roussillon. All rights reserved.
//
import Foundation
import XCTest
import Quick
import KIF

extension QuickSpec {
	public var tester: KIFUITestActor { return tester() }
	public var system: KIFSystemTestActor { return system() }
	
	private func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
		return KIFUITestActor(inFile: file, atLine: line, delegate: self)
	}
	
	private func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
		return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
	}

}
