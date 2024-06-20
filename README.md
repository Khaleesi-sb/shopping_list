# Shopping List App

## Overview
The Shopping List app is a Flutter application that allows users to manage their shopping lists efficiently. With Firebase as the backend, users can add items, fetch all items, and delete items by swiping the item data tile. This app provides a seamless experience for keeping track of shopping items.

## Features
- **Add Items:** Users can add new items to their shopping list.
- **Fetch Items:** Users can fetch all items from their shopping list.
- **Delete Items:** Users can delete items by swiping the item data tile.

## Installation

### Prerequisites
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase project: [Set up a Firebase project](https://firebase.google.com/docs/web/setup)

### Steps
1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/shopping-list-app.git
   cd shopping-list-app
   
2. **Install dependencies:**
    ```bash
   flutter pub get
   
3. **Set up Firebase:**
   - Go to the Firebase Console.
   - Create a new project or select an existing project.
   - In the Firebase Console, navigate to "Realtime Database" in the left-hand menu.
   - Click on "Create Database" and follow the prompts to set up your database.
   - Once the database is created, you will see your database URL in the form of https://<your-database-name>.firebaseio.com/.
   - Copy this URL as it will be used in your Flutter app for network requests.

4. **Run the app:**
    ```bash
   flutter run
   
### Usage
- **Adding an item:**
    - Click on the "Add Item" button.
    - Enter the item name and details.
    - Press "Save" to add the item to the list.
- **Fetching items:**
    - The shopping list is automatically updated with the latest items from Firebase.
- **Deleting an item:**
    - Swipe the item data tile to the left or right to delete it from the list.

### Contributing
**Contributions are welcome! Please follow these steps:**
  - Fork the repository.
  - Create a new branch: git checkout -b feature-name.
  - Make your changes and commit them: git commit -m 'Add some feature'.
  - Push to the branch: git push origin feature-name.
  - Submit a pull request.

### Contact
For any questions or suggestions, please contact khaleesi.b914@gmail.com