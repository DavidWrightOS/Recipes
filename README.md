# <img width="70" alt="List Screen (light)" src="https://github.com/user-attachments/assets/b970f7f2-2c93-45b8-9185-1f7463936328" /> &nbsp; The Recipes App



### Summary:
The Recipes app is a single-screen app that fetches and displays a list of recipes from an API endpoint. Images are fetched and displayed asynchronously, and only as needed (when the corresponding recipe is visible on screen). Images are also cached and persisted locally.

The app is built entirely in SwiftUI and follows MVVM architecture. Swift Concurrency (async/await) is used for all asynchronous operations. There are no external dependencies.

Errors are handled gracefully and the app logic is well tested with unit tests. The service layers (networking/caching/persistence) rely heavily on protocols and dependency injection for testability. 

<img width="250" alt="List Screen (light)" src="https://github.com/user-attachments/assets/c87cc939-8e3e-48cb-a705-ec5faad79fdd" />
<img width="250" alt="No Recipes Screen (light)" src="https://github.com/user-attachments/assets/3bed9c5e-cdb4-4e93-a5f0-21e2dd704323" />
<img width="250" alt="Error Screen (light)" src="https://github.com/user-attachments/assets/35d80ab5-f05c-422d-bf47-8deb4654ff6e" />

#### Simulating a poor network connection:
| Async, On-Demand Image Fetching | Graceful Error Handling |
| :---: | :---: |
| <img width="250" alt="Async Image Loading" src="https://github.com/user-attachments/assets/cee84c0e-d3df-4917-aa2b-f0028490b058" /> | <img width="250" alt="Graceful Error Handling" src="https://github.com/user-attachments/assets/680fd1b5-dd7a-48f8-9fcf-46a48c3d9001" /> |



### Focus Areas:
I prioritized **clean, maintainable code and testability** because they are crucial to building a robust, scalable codebase. Sure, unit tests and separation of concerns may not be as flashy as a sleek UI with fancy filtering and sorting options, but they make a lasting impact. Most iOS engineers can implement a feature to spec; the real difference lies in how it's built. My goal was to demonstrate that the code I write helps pay down tech debt, not add to it.



### Time Spent:
**Total Time: ~12-14 hours**

#### Breakdown:
* Project setup, fetch/display recipes: 3 hours
* Async fetching/caching images: 2-3 hours
* Add persistence layer: 2 hours
* Error handling and edge case testing: 2-3 hours
* Writing unit tests: 2 hours
* Custom app icon and splash image: <1 hours



### Trade-offs and Decisions:
* **Non-Generic Protocols:** I prioritized simplicity and clarity over flexibility by keeping protocols specific to their intended use rather than making them generic.
* **Image Persistence Location:** Due to the potentially large footprint of storing an indeterminite number of image files, and the non-critical nature of the data, I chose to store images in the caches directory, rather than the documents directory. This allows the OS to handle purging cached images when necessary, reducing the need for manual data management.
* **Protocol-Oriented Dependency Injection:** Protocols clearly define dependency functionality. Closures, on the other hand, offer more flexibility by allowing specific functionality to be injected piece-meal, but can make dependency injection more verbose. I opted to use protocol-oriented dependency injection, prioritizing readability and ease-of-use.



### Weakest Part of the Project:
**Limited functionality:**
Due to time constraints, I did not implement any filtering, sorting, or search functionality. Additionally, I considered adding a recipe detail screen with a larger image and video player. Given more time, these features would be my next focus for improvement.
