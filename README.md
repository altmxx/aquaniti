# AquaNiti
Youtube Video: https://www.youtube.com/watch?v=ln1jMbXmfKc

## Project Overview

### Problem Statement

Develop a user-friendly application to calculate water footprints for various daily use items using digital technology.

### Solution

The AquaNiti project proposes a mobile application that leverages object detection and a comprehensive water footprint database to calculate the water footprint of everyday products in real-time.

## How it Works

### Real-Time Object Detection

The application uses YOLOv5, a real-time object detection system, to scan objects using the phone's camera. Once an object is scanned, the app will identify it and retrieve its water footprint data from the cloud.

### Water Footprint Calculation

After identifying the object, the app estimates the product's weight to calculate a more precise water footprint using Life Cycle Assessment (LCA) data.

### Data Storage

Water footprint data for various products is stored on a blockchain to ensure data security and tamper-proof records.

### Data Visualization and Analytics

The application utilizes geospatial maps and advanced analytics to present water footprint data to the Government on a state-by-state basis. This will empower policymakers with insights into water usage patterns across different regions.

## App Functionalities

- **Consumer Use Case**: Consumers can utilize the app to check the water footprint of products before purchasing, enabling them to make more sustainable choices.
  ![image](https://github.com/altmxx/aquaniti/assets/104318895/956a6741-58a4-4d4e-975a-eeca9b348f66)


- **Government Use Case**: Government agencies can leverage the app's data to plan and implement water management and pollution control strategies.
![image](https://github.com/altmxx/aquaniti/assets/104318895/0caf9120-986e-401c-bae8-cebd977fd245)

## Tech Stack

- **Mobile App Development**: Flutter
- **Object Detection**: YOLOv5 (You Only Look Once)
- **Tflite**: to make the model available on mobiles
- **Database**: Firebase
- **REST API**: to connect the mobile app to the backend services.
- **Blockchain**: zkEVM (zero-knowledge Ethereum Virtual Machine), Polygon
- **Machine Learning Kit (ML Kit)**: for Firebase

## Unique Selling Points (USPs)

- **Real-time Water Footprint Tracking**: The application leverages YOLOv5 for real-time object detection and water footprint estimation.

- **Data Security**: Data is secured on a blockchain using zero-knowledge proofs.

- **Advanced Analytics and Visualization**: The app offers advanced analytics and visualization tools to present water footprint data on a national scale.

- **Educational Content**: The application includes informative articles about water conservation and its environmental impact.

- **Eco-Certification Program**: The project envisions an eco-certification program to recognize businesses committed to reducing their water footprint.
