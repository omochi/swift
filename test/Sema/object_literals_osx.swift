// RUN: %target-typecheck-verify-swift
// REQUIRES: OS=macosx

struct S: _ExpressibleByColorLiteral {
  init(_colorLiteralRed: Float, green: Float, blue: Float, alpha: Float) {}
}

let y: S = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
let y2 = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) // expected-error{{could not infer type of color literal}} expected-note{{import AppKit to use 'NSColor' as the default color literal type}}
let y3 = #colorLiteral(red: 1, bleen: 0, grue: 0, alpha: 1) // expected-error {{incorrect argument label in call (have 'grue:', expected 'blue:')}} 
// expected-error@-1 {{incorrect argument label in call (have 'bleen:', expected 'green:')}}
// expected-error@-2 {{could not infer type of color literal}} 
// expected-note@-3 {{import AppKit to use 'NSColor' as the default color literal type}}

struct I: _ExpressibleByImageLiteral {
  init(imageLiteralResourceName: String) {}
}

let z: I = #imageLiteral(resourceName: "hello.png")
let z2 = #imageLiteral(resourceName: "hello.png") // expected-error{{could not infer type of image literal}} expected-note{{import AppKit to use 'NSImage' as the default image literal type}}

struct Path: _ExpressibleByFileReferenceLiteral {
  init(fileReferenceLiteralResourceName: String) {}
}

let p1: Path = #fileLiteral(resourceName: "what.txt")
let p2 = #fileLiteral(resourceName: "what.txt") // expected-error{{could not infer type of file reference literal}} expected-note{{import Foundation to use 'URL' as the default file reference literal type}}

let text = #fileLiteral(resourceName: "TextFile.txt").relativeString! // expected-error{{could not infer type of file reference literal}} expected-note{{import Foundation to use 'URL' as the default file reference literal type}}

// rdar://problem/49861813
#fileLiteral() // expected-error{{missing argument for parameter 'resourceName' in call}} expected-error{{could not infer type of file reference literal}} expected-note{{import Foundation to use 'URL' as the default file reference literal type}}
