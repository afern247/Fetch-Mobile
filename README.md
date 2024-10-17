# Fetch Mobile Take-Home Project

### Steps to Run the App

Clone the repo and open `fetch.xcodeproj` and run it on the simulator.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

- **UI**: Since it's the entry point for users, visuals are crucial. While I’m not a designer, I believe the result is elegant and simple.
- **Latest Tech**: I’m up to date with the latest technology, so I incorporated new features like the `@Observable` environment and async/await.
- **Performance**: I used Lazy views to load data only when needed, avoiding unnecessary resource consumption. I also implemented image caching (as per instructions) on disk.
- **State Management**: I utilized `@Observable` and `@Environment` for state management to ensure a reactive and clean approach, making the app more responsive and easier to maintain.
- **Error Handling**: I implemented error handling in the networking layer to ensure the app gracefully handles failures, providing a better user experience when data cannot be fetched.
- **Scalability**: The app follows the MVVM architecture, which makes it easy to scale and maintain. This separation of concerns ensures that future features can be added without major refactoring.
- **User Experience**: I focused on smooth transitions, animations, and loading states to ensure a seamless and polished user experience.
- **Testing**: Although I didn’t focus heavily on testing, I recognize the importance of unit tests for long-term stability and would prioritize them in a production environment.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent around 4-5 hours on this project, focusing first on core functionality (fetching and displaying data), then on performance optimizations (lazy loading, image caching), and finally polishing the UI with animations and transitions. My goal was to write production-ready code by focusing on clean architecture (MVVM), performance optimizations, and using the latest SwiftUI features.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Time was the main trade-off to make the project more robust.

### Weakest Part of the Project: What do you think is the weakest part of your project?
UITest

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

No, I didn’t use any to avoid potential penalties (if that’s applicable). However, in a real project, I would have chosen Alamofire as the first library. It’s a great package and a must-have for networking.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered

As a bonus, I included the company’s icon logo. I think it adds a touch of authenticity, similar to the real app on the App Store.
