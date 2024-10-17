# Fetch Mobile Take Home Project

### Steps to Run the App

Clone the repo and open `fetch.xcodeproj` and run it on the simulator.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

- **UI**: Because it's the entry point of anything, visuals are important in life. I'm not a designer, but I think it came out pretty elegant and simple.
- **Latest Tech**: I'm up to date with the latest technology, so I included everything new, from the new `@Observable` environment to async/await.
- **Performance**: I'm using Lazy views to load each data when needed to avoid overwhelming the view and consuming extra resources, as well as caching the images (as per instructions) on disk.
- **State Management**: I used `@Observable` and `@Environment` for state management to ensure a reactive and clean approach, making the app more responsive and easier to maintain.
- **Error Handling**: I implemented error handling in the networking layer to ensure that the app gracefully handles failures, providing a better user experience when data cannot be fetched.
- **Scalability**: The app follows the MVVM architecture, which makes it easy to scale and maintain. This separation of concerns ensures that future features can be added without major refactoring.
- **User Experience**: I focused on smooth transitions, animations, and loading states to ensure a seamless and polished user experience.
- **Testing**: Although I didn't focus heavily on testing, I considered the importance of unit for long-term stability and would prioritize them in a production environment.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent around 4-5 hours on this project, focusing first on core functionality (fetching and displaying data), then adding performance optimizations (lazy loading, image caching), and finally polishing the UI with animations and transitions.
I aimed to write production-ready code by focusing on clean architecture (MVVM), performance optimizations, and using the latest SwiftUI features.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
Time, to be able to make it more robust.

### Weakest Part of the Project: What do you think is the weakest part of your project?
UITest(?)

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
No I didn't use any to not be penalized (if there is such a thing) but if a library I would have used in a real project is Alamofire, I think it's a great package and a must have.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered
I also included the company icon logo as a bonus. I think it gives it a touch of authenticity, similar to the real app on the App Store.
