# Guidelines

* All commits are in English language, lowercase (except class and method names; as defined), short and precise
* All classes are prefixed with default class prefix. e.g. "PS"
* Use spaces in Xcode
* Install and use [git-flow](http://github.com/nvie/gitflow)
* Code has to be formatted as stated in the sample code below
* Don't commit huge files into the repository
* Development is done on the 'develop' branch created by git-flow, never on master
* Experimental feature branches are prefixed with 'x-'
* Only letters from 'a' to 'z' and hyphens are used in branch names

# Code Style Example

Sample Header:

	//  GTMFoo.h
	//  FooProject
	//
	//  Created by Greg Miller on 6/13/08.
	//  Copyright 2008 Google, Inc. All rights reserved.
	//

	#import <Foundation/Foundation.h>

	// A sample class demonstrating good Objective-C style. All interfaces,
	// categories, and protocols (read: all top-level declarations in a header)
	// MUST be commented. Comments must also be adjacent to the object they're
	// documenting.
	//
	// (no blank line between this comment and the interface)
	@interface GTMFoo : NSObject {
	  NSString *stringProperty_;
	  NSObject *otherObject_;
	  NSString *foo_;
	  NSString *bar_;
	}
	
	// Always copy NSStrings
	@property (nonatomic, copy) NSString *stringProperty;
	
	// Other objects are simply retained
	@property (nonatomic, retain) NSObject *otherObject;

	// Returns an autoreleased instance of GMFoo. See -initWithString: for details
	// about the argument.
	+ (id)fooWithString:(NSString *)string;

	// Designated initializer. |string| will be copied and assigned to |foo_|.
	- (id)initWithString:(NSString *)string;

	// Gets and sets the string for |foo_|.
	- (NSString *)foo;
	- (void)setFoo:(NSString *)newFoo;

	// Does some work on |blah| and returns YES if the work was completed
	// successfuly, and NO otherwise.
	- (BOOL)doWorkWithString:(NSString *)blah;

	@end
	
Sample Implementation:

	//
	//  GTMFoo.m
	//  FooProject
	//
	//  Created by Greg Miller on 6/13/08.
	//  Copyright 2008 Google, Inc. All rights reserved.
	//

	#import "GTMFoo.h"

	@implementation GTMFoo
	@synthesize stringProperty;
	@synthesize otherProperty;

	+ (id)fooWithString:(NSString *)string {
	  return [[[self alloc] initWithString:string] autorelease];
	}

	// Must always override super's designated initializer.
	- (id)init {
	  return [self initWithString:nil];
	}

	- (id)initWithString:(NSString *)string {
	  if (self = [super init]) {
	    foo_ = [string copy];
	    bar_ = [[NSString alloc] initWithFormat:@"hi %d", 3];
	  }
	  return self;  
	}

	- (void)dealloc {
	  MCRelease(foo_);
	  MCRelease(bar_);

	  [super dealloc];
	}

	- (NSString *)foo {
	  return foo_;
	}

	- (void)setFoo:(NSString *)newFoo {
	  [foo_ autorelease];
	  foo_ = [newFoo copy];  
	}

	- (BOOL)doWorkWithString:(NSString *)blah {
	  // ...
	  return NO;
	}

	@end

