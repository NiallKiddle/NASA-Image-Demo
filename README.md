# NASA-Image-Demo
Demo project using the NASA Search API
=========

# Description

This project uses the NASA Image Search API to fetch images related to 'The Milky Way' structured using the MVC design pattern. It demonstrates caching and asynchronous loading of images without the use of any third party frameworks or libraries.

# Building the project

You must use the latest Xcode. The project targets iOS 12.1 and is written with Swift 4.2. It does not have any external dependencies.

Simply hit build and run!

# Approach

1. I have chosen to stay away from third party frameworks and libraries, purely because it gives me more control over the project compared to if I wanted to use a package. Aswell as the fact it removes any dependancies on external teams that have written the package if something was to go wrong.
2. The interface is built using standard UIKit classes and incorporates the use of `UICollectionView` and `UIScrollView`.
3. `URLSession` performs a high level operation using `dataTask` which is contained within the `NetworkController.swift`.
4. The API returns a JSON response which is decoded into separate structs each detailed in `JSON objects` using the `Codable` protocol with `JSONDecoder`. These custom models are constructed by the controller and completion handlers in the `HomeViewController.swift` class allows it to be received and displayed.
5. If the image has not been downloaded previously, the image data is fecthed in the `NetworkController.swift` where it is then cached using `NSCache<NSString, UIImage>()`.
6. The HTTP request is asynchronous and gets fired via `cellForItemAt` to ensure that only the necessary images are downloaded at a time.

# Short comings

1. Currently any API request is sent via the fixed endpoint, I would have liked to have made the http request more extensive by manipulating the api paramters to allow the date range to be changed with some form of interface.
