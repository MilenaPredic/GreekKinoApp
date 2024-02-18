# Greek Kino App

## Overview

Greek Kino is a popular lottery game based on number draws. This mini-app allows users to track draws, select numbers to play, and view results without betting capabilities. It offers a dynamic experience with countdown timers to each new draw, enabling the selection of up to 15 numbers from a set of 80.

## Features

### **Upcoming Draws Overview**

- Displays 20 upcoming draws with countdown timers.
- Provides draw number and time information.

### **Betting Slip for Number Selection**

- Users can choose up to 15 out of 80 numbers.
- Selected numbers are visually highlighted on the slip.
- Displays the count of selected balls, draw time, draw number, and the remaining time for "placing a bet".

### **Drawing Display**

- A separate screen for drawing animation within a Web View component.
- Animation is accessible through the specified URL.

### **Results (Bonus Task)**

- A results screen showing drawn balls per draw, including draw time and number.

## Technical Details

### Architecture

MVVM + Repository Pattern
The application is structured around the MVVM (Model-View-ViewModel) architecture complemented by the Repository pattern. This design choice facilitates a clear separation between the UI, business logic, and data sources, enhancing maintainability and testability.

### Main Components

- **ViewModels**: Manages the logic for data presentation in UI components.
- **Views**: Defines the UI and handles user interactions.
- **Models**: Specifies the app's data structures.
- **Repository**: Manages fetching data from local or network sources.

### Technologies Used

- **SwiftUI** for UI development.
- **Combine** for handling asynchronous tasks and event management.
- **WebKit** for displaying web content.

### Testing

Includes unit tests covering the ViewModel logic, utilizing mock objects and protocols for dependency simulation in a testing environment.

## Installation and Launch

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Execute the build for your desired simulator or iOS device.

## Conclusion

The Greek Kino App offers a fun and interactive way to engage with the Greek Kino lottery game without the element of betting. Designed with a focus on user experience, it features a clear and intuitive interface for game tracking and participation.
