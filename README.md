# E-commerce Mobile Development Project
## Project Overview

You are required to develop a **mobile e-commerce platform** for vendors and shoppers in Egypt. The platform allows **vendors** to create profiles and list products, while **shoppers** can browse products, comment, rate, and place orders. The application should be developed with a focus on a user-friendly UI and UX, following good development practices.

## Project Requirements

### 1. User Roles and Features

#### Vendors
- Vendors must be logged in to create profiles and list products.
- Can add products with images, descriptions, prices, and categorization.
- Should have the ability to announce discounts on their products, triggering push notifications to shoppers.

#### Shoppers
- Can **browse**, **search**, and **read** product details without logging in.
- Must be logged in to add **comments** and **rate** products.
- Average product rating should be displayed on each product page.
- Can add products to their **shopping cart** and proceed to checkout.

### 2. App Screens and Navigation

The app should include multiple screens with appropriate navigation (bottom navigation, tabs, drawer menus). The following screens are required:

- **Sign Up / Sign In**:
  - Allow new users to register and existing users to log in.
  - Differentiate between shoppers and vendors.

- **User Profile**:
  - Vendors can manage profiles and their listed products.
  - Shoppers can manage personal details and view order history.

- **Products Overview**:
  - A screen to list products based on categories, with search functionality.
  - Users can filter and sort products.

- **Product Details**:
  - A detailed product page with images, descriptions, pricing, comments, and average ratings.
  - Option to add products to the shopping cart.

- **Vendor Profile**:
  - Vendor-specific profile that displays their listed products and contact information.

- **Shopping Cart**:
  - Displays products added by the shopper, with options to modify quantities or remove items.
  - Option to proceed to checkout.

### 3. Database Requirements

Use **Firebase** as the online database to store and manage data, including:

- **Users**:
  - Store user information for both shoppers and vendors.
  - Authentication data, including secure storage of credentials and tokens.

- **Products**:
  - Store product details such as images, descriptions, pricing, ratings, and comments.

### 4. Push Notifications

The application must include **push notifications** to keep users informed. Examples include:

- A **vendor adds a product**.
- A **vendor announces a discount**.
- New **comments** on a product.

### 5. Error Handling

Proper error handling must be implemented to improve user experience, including:

- **Connection Issues**:
  - Display an appropriate message if network issues occur.

- **Wrong Inputs**:
  - Validate inputs like email, password, and product information.

- **Wrong Credentials**:
  - Display a meaningful error message if login credentials are incorrect.

### 6. Out-of-Scope Features

You are required to include at least **two additional features** beyond the course scope, such as:

- **Image Upload**:
  - Allow users to upload product images from their gallery or camera.

- **Email or SMS Notifications**:
  - Send confirmation emails or SMS messages to users for events like registration or order placement.

- **Shopping Cart Process**:
  - Implement a complete shopping cart system, including secure transactions.

- **Persistent Login**:
  - Use **refresh tokens** to keep users logged in even after closing the app.

### 7. User Interface and User Experience (UI/UX)

Ensure the app provides a good UI/UX by following these guidelines:

- **Prototype Development**:
  - Create a prototype using **Figma**. Include all necessary screens.
  - Use existing templates if necessary.

## Development Plan

### Tools & Technologies
- **Frontend Framework**: Use a cross-platform framework like Flutter or React Native.
- **Database**: Firebase Realtime Database or Firestore.
- **Authentication**: Firebase Authentication.
- **Push Notifications**: Firebase Cloud Messaging (FCM).
- **Prototyping**: Figma.
- **UI Libraries**: Cupertino for iOS and Material for Android.

### Development Steps

1. **Set Up Firebase**:
   - Configure Firebase for authentication, database, and push notifications.

2. **Create User Interfaces**:
   - Prototype screens in **Figma**, then implement them in your mobile development framework.

3. **Implement Authentication**:
   - Create screens for login, registration, and role-based access for vendors and shoppers.

4. **Develop Product Management**:
   - Build screens for product listing, product details, adding/editing products.

5. **Implement Shopping Cart**:
   - Develop shopping cart functionality to manage products, update quantities, and proceed to checkout.

6. **Add Push Notifications**:
   - Use FCM to notify users of product updates, discounts, and comments.

7. **Error Handling and Testing**:
   - Implement error handling for connection issues and input validation. Test all features thoroughly.


