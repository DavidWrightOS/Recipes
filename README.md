# <img width="70" alt="List Screen (light)" src="https://github.com/user-attachments/assets/b970f7f2-2c93-45b8-9185-1f7463936328" /> &nbsp; The Recipes App



## Summary:

The Recipes app is a single-screen app that fetches and displays a list of recipes from an API endpoint. Images are fetched and displayed asynchronously, and only as needed (when the corresponding recipe is visible on screen). The images are also cached and persisted locally.

The app is built entirely in SwiftUI and follows MVVM architecture. Swift Concurrency (async/await) is used for all asynchronous operations. Errors are handled gracefully and the app logic is well tested with unit tests. The service layers (networking, caching, and persistence) rely heavily on protocols and dependency injection for testability. There are no external dependencies.

<img width="250" alt="List Screen (light)" src="https://github.com/user-attachments/assets/c87cc939-8e3e-48cb-a705-ec5faad79fdd" />
<img width="250" alt="No Recipes Screen (light)" src="https://github.com/user-attachments/assets/3bed9c5e-cdb4-4e93-a5f0-21e2dd704323" />
<img width="250" alt="Error Screen (light)" src="https://github.com/user-attachments/assets/35d80ab5-f05c-422d-bf47-8deb4654ff6e" />

#### Simulating a poor network connection:

| Async, On-Demand Image Fetching | Graceful Error Handling |
| :---: | :---: |
| <img width="250" alt="Async Image Loading" src="https://github.com/user-attachments/assets/cee84c0e-d3df-4917-aa2b-f0028490b058" /> | <img width="250" alt="Graceful Error Handling" src="https://github.com/user-attachments/assets/680fd1b5-dd7a-48f8-9fcf-46a48c3d9001" /> |



## Focus Areas:

I prioritized **clean, maintainable code and testability** because they are crucial to building a robust, scalable codebase. Sure, unit tests and separation of concerns may not be as flashy as a sleek UI with fancy filtering and sorting options, but they make a lasting impact. Most iOS engineers can implement a feature to spec; the real difference lies in how it's built. My goal was to demonstrate that the code I write helps pay down tech debt, not add to it.



## Time Spent:

#### Total Time: ~12-14 hours**

#### Breakdown:

| Task | Time Spent |
| :--- | :--- |
| Project setup, fetching/displaying recipes | 3 hours |
| Async fetching/caching images | 2-3 hours |
| Add persistence layer | 2 hours |
| Error handling and edge case testing | 2-3 hours |
| Writing unit tests | 2 hours |
| Custom app icon and splash image | <1 hours |



## Trade-offs and Decisions:

Below is a list of some of the trade-off decicions I made while developing this project. You will notice a common theme among them: prioritizing simplicity over flexibility. This allowed me to be more explicit with my types, which tends to makes for more concise and readable code. Don't get me wrong, flexibility can be a great thing and it definitely has its place, but over-abstraction should also generally be avoided. Especially given the small scope of this project, flexibility very often wasn't worth the cost of added complexity.

* **Non-Generic Protocols:**
  * I kept protocols type-specific, rather than making them generic. prioritized simplicity and clarity over flexibility by keeping protocols specific to their intended use, rather than making them generic.

* **Image Persistence Location:**
  * Due to the potentially large footprint of storing an indeterminite number of and size of image files, combined with the non-critical nature of this image data, I chose to persist images in the caches directory rather than the documents directory. This allows the OS to handle purging cached images when necessary, reducing the need for manual data management.

* **Protocol-Oriented Dependency Injection:**
  * Dependency injection makes our code more testable by allowing us to inject Mock dependencies during testing. Protocols are great for this because they allow us to clearly define the public interface that a particular dependency needs to have. But protocols are not the only way to inject dependencies; we could instead inject functionality with closures. The benefit of using closures is it allows specific functionality to be injected piece-meal--this effectively lets objects decide for themselves what functionality they dependend on, rather than relying on a protocol which could potentially define more functionality than is actually required. However, one of the downsides to injecting closures is it can make the dependency injection code more verbose and less readable. I decided to use protocol-oriented dependency injection, once again prioritizing readability and ease-of-use over flexibility.



## Weakest Part of the Project:

**Limited functionality:** 
Due to time constraints, I did not implement any filtering, sorting, or search functionality. Additionally, I had initially considered adding a recipe detail screen with a larger image and/or video player. Given more time, these features would be my next focus for improvement.



## Additional Information:

There are a couple of housekeeping items that did not get as much attention as they deserve due to time constraints:
* **Documentation:**
  * I added comments and documented the code in some places, but I wasn't as consistent with documentation as I typically like to be. 

* **Logging:**
  * There's also quite a bit of room for improvement regarding the logging, or lack there of. There are a few places where errors fail silently (e.g. when persisting an image to disk). These errors are intentionally ignored so as not to disrupt the UI/UX, but it would still be a good idea to add some logging around these errors so they don't go completely unnoticed from the development side of things.
