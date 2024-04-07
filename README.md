# XALER

Welcome to Xaler, Xaler is an app (WIP) developed in Flutter / Dart which helps people to Relax and track their progress to improve their responses to Anxiety.
This is also an app that will hopefully motivate its users and combat their day-to-day worries and anxiety.

The app aims to help people keep track of their anxiety and improve their mental well-being, with features such as an in-app journal, Meditation and mindfulness audios, and more.

This app has been developed as a solo Final year project for my Software Engineering degree. This has included the planning, design, development, and testing of the application.


Key Implementation features of this app include:
 - Cloud Database connection and data storage
 - Cloud-based user authentication
 - User ability to provide feedback to the developer
 - Asynchronous loading and functionality
 - Informed User Interface design based on recommended principles, heuristics, and previous research papers.

# Design and Functionality:

## User Login
- Login functionality is made possible via Google Firebase's Authentication service.
- This allows for login and checking of credentials, and creation of user accounts.
- Automatic login of users if they have previously logged in on this device.
- Password reset functionality
  
![SmallLoginMockup](https://github.com/Luke-Cragg/xaler/assets/124095690/ffb78e7f-d30c-4bdf-8cea-fa7861bf878a)

## Home Page
 - Features a randomly selected quote of the day
 - Random daily challenges to increase user engagement
 - Daily check-ins where the user can get advice and feedback on their responses

![smallHomeMockup](https://github.com/Luke-Cragg/xaler/assets/124095690/04a0889f-142f-44f1-ad7c-f3ab0d6f8323)
![SmallCheckinResponse](https://github.com/Luke-Cragg/xaler/assets/124095690/91d1ec44-6089-417c-b5c2-fc697f168212)


## Mindfulness Page
 - Features hand-selected meditation and mindfulness audios from the [FreeMindfulnessProject](https://www.freemindfulness.org/welcome)
 - Allows for background playing whilst phone screen is off / app running in the background
 - Standard Pause/Resume functionality
   
 ![smallMindfulnessPage](https://github.com/Luke-Cragg/xaler/assets/124095690/ee695359-fa9f-4ae2-8973-b5ffd331b60f)

## Journal
 - Allows users to create journal entries to track their progress and look back on previous entries
 - Users have the ability to delete if they no longer want to view previous entries
 - Powered by Firebase Firestore DB for storing journal entries

![smallJournalPage](https://github.com/Luke-Cragg/xaler/assets/124095690/325aa349-c921-4662-8177-dbe345887be2)

## Resources
 - List of resources for the user to access. Includes Emergency helplines and contacts, other applications to help with mental health, and much more.
 - Page is also used to recommend features within the app for the user to access.

![SmallResourcePage](https://github.com/Luke-Cragg/xaler/assets/124095690/935fc8ea-c8ba-4d04-8cae-601dccb574bc)
