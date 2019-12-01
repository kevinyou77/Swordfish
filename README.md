

# Swordfish - Better Binus Mobile
A no BS Bimay client for iOS

[**APP DEMO**](https://youtu.be/794d-_V5VeQ)

## **What’s this?**

A college companion app for Binus University students. You can see your upcoming schedules, GPAs, and billing information in this app.

**THIS APPLICATION IS STILL IN A VERY EARLY STAGE, THINGS ARE GOING TO BREAK DOWN QUITE OFTEN. THIS APP WILL NOT WORK ON ANYONE THAT HAS A STAFF ACCOUNT ON BINUSMAYA BECAUSE ROLE VALIDATION IS NOT YET IMPLEMENTED 
Also, I'm not responsible for anything you do with this application and I don't collect your data. All user related data is stored locally, they ain't going to some shady server so don't worry about it. 
This is a THIRD PARTY app, developed INDEPENDENTLY from Binus University, by interested Binusians. This is NOT A REPLACEMENT for the Binusmaya website, information provided in it is NOT GUARANTEED TO ALWAYS BE VALID. (Copy pasted from Portal's Google Play Page)**

## **A bit of a backstory**

This project is inspired by [**Portal for BinusMaya**](https://github.com/chrsep/Kingfish), which I’ve used extensively from class to class. At the time I was amazed. How can an individual develop an app that precisely know what the student wants, great looking UI, and most importantly, while being much more better than the official BinusMaya app, which is probably developed by a team.  Even when Binus relaunched their mobile app, it couldn’t dethrone Portal, that’s just how good it is. I always wanted to know where my money went to be honest. Oh and, their API design gives me nightmares.

This project started as one of my fun side projects as I’m learning Swift and I wanted to put my knowledge to use.
Note that this application is built in about 17 days, **there will be bugs (lots of it), the codebase is still pretty messy.** I decided to open-source this application because I’m on my final year and I should be working on my thesis. Not that I’m abandoning this project, I will continue develop this app in the future, just that I’m shifting my priorities right now.

Also, I don't know if this project will ever go on the AppStore due to Apple's app review policy. Chances are slim I would say, because Binus doesn't actually provide an official API access.

## **Tools and Libraries Used**

 - [**Swift (Programming Language)**](https://developer.apple.com/swift/), Swordfish is written entirely in Swift
  - [**Realm**](https://realm.io/docs/swift/latest/), Used to persist data locally 
   - [**RxSwift**](https://github.com/ReactiveX/RxSwift), This project was originally written with PromiseKit, but after seeing the FRM (Functional Reactive Programming) hype, I
   decided to make my life harder by migrating to RxSwift. Used to
   handle asynchronous requests and reactive UI
   - [**Texture**](https://texturegroup.org/), UI framework that comes with their own layout engine, why? Because AutoLayout sucks.
   - [**RxTableDataSources**](https://github.com/RxSwiftCommunity/RxDataSources/), Makes your life and mine easier when dealing with table data binding with Rx
   - [**SwiftSoup**](https://github.com/scinfu/SwiftSoup), To extract data and stuffs from HTML
   - [**CocoaPods**](https://cocoapods.org/), to manage dependencies

**Note that there’s no Dependency Injection in this application as of now.**

## **Architecture**
This project is built with MVVM in mind,  [here's quick explanation to MVVM](https://www.youtube.com/watch?v=bFoLlwuzAtk)
These are the classes on this application
- **Extensions**, the name it self should be pretty self explanatory. It is an extension for built in Swift types.
- **ViewModels**, 	before serving data to view controller, process data needed by view controller.
- **Views**, all view controllers is here
- **Repositories**, used to retrieve and save data to Realm, the local database.
- **Helpers**,  utility functions to assist in development.
- **Network**, do everything network related here (HTTP requests etc.)
- **Entities**, objects to store data from HTTP requests / Realm
- **Interactor**, business logics are here, interactor does the heavy lifting for you before you go into ViewModels
- **Dependencies**, Manual Dependency Injection using Protocols from [here](https://swiftwithmajid.com/2019/03/06/dependency-injection-in-swift-with-protocols/)

If you wanted to know your realm db location, just check the console. I’ve printed it out for you. 

## **Contributing**
**This project is on GitHub for a reason.** The source code is available for you to read. **Any contribution would be much appreciated.** I’m a firm believer in learning by doing. Getting your hands dirty is the first step to learn anything, it could be a starting point for you to learn iOS development. 

**Discovered a bug?** Bring up the issue. 
**Ideas that would make this app better?** Open up a thread. 
**Fixed a bug? Implemented a new feature?** Open a pull request and I’ll help to review it. 

**I know that this application is miles away from perfect, and the codebase is probably going trigger PTSD for some software engineers out there, but I'm learning slowly.** This is also the first time I’m implementing design patterns in an application. I would love your feedbacks on the architectural pattern I’m implementing.
As a way to start things off, I’m opening a few issues for this app. Have fun.
