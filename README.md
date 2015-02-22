# HitList2

My next app will be in Swift, and it will use Core Data for object persistence. I recently learned Swift, and I needed to figure out Swiftian Core Data. Pietro Rea’s excellent [tutorial](http://www.raywenderlich.com/85578/first-core-data-app-using-swift) “Your First Core Data App Using Swift” was an excellent start on this, but the code in the tutorial has two limitations.

First, the code uses KVC, rather than a `NSManagedObjectContext` subclass, to manipulate data. So, `person.setValue(name, forKey: "name")` rather than `person.name = name`. This approach is more verbose, and a typo in the key name would cause an runtime error.

Second, as in Apple’s Core Data boilerplate, the code for setting up the Core Data stack is all in `AppDelegate.swift`. This violates the [single responsibility principle](http://en.wikipedia.org/wiki/Single_responsibility_principle), which “states that every class should have a single responsibility, and that responsibility should be entirely encapsulated by the class”. The [responsibility](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/index.html) of the class implementing UIApplicationDelegate is to respond "to important events in the lifetime of your app." Getting into the weeds of setting up the Core Data stack could not be further removed, in my view, from this responsibility. Rather, the one situation in which that class should interact with Core Data is to save the context when the application is about to terminate.

HitList2 addresses these limitations. First, the app uses a `NSManagedObjectContext` subclass to manipulate data. Second, the app moves the setup of the Core Data stack to its own singleton utility class, `CDManager`, but still saves the context when the app is about to terminate.

As an aside, CDManager uses Martin Rue's clever [implementation](http://code.martinrue.com/posts/the-singleton-pattern-in-swift) of the Singleton pattern.

