# Nyayapath
An AI-powered mobile application designed to simplify and accelerate access to justice. Built during a hackathon, this app helps users understand their legal issues through natural language queries, provides AI-generated summaries of legal texts, and guides them through appropriate legal pathways.
Download link - https://drive.google.com/drive/u/0/folders/1I5tcbywNqJlJotuqPi23rBOfI4_Nowjo (username-priyanshutest pass-123456)
# Problem Statement
In India, millions of citizens struggle to navigate the complex legal system due to lack of awareness, accessibility, or resources. With courts overburdened and legal processes being slow and confusing, there's a pressing need for a solution that bridges this gap — especially for marginalized communities.

# Our Solution
We built a mobile app that:

Allows users to input their issues in simple natural language

Classifies the type of legal problem (e.g., civil, criminal, labor)

Summarizes long legal documents into easy-to-read texts using a TFLite summarizer

Suggests initial legal actions or resources

Stores user queries and summaries securely for future use

# Why an App over a Website?
Accessibility: Most users, especially in rural India, use smartphones rather than desktops.

Portability: An app enables users to carry legal assistance in their pocket.

Offline capabilities: Potential to support offline queries in future updates.

Notifications & Personalization: Easier to alert users about case updates or legal awareness drives.

# Features

- Legal Summarizer model optimized for mobile using TFLite

- Query History & Secure Storage

- Multilingual Support (coming soon)

- Secure backend with Django API

# Tech Stack
- Frontend: Flutter
- Backend: Django REST Framework 
- AI/ML Models:	TensorFlow Lite (Intent & Summary)
- Summarization:	Custom trained T5-based model

# Setup Instructions

## Clone the repo
```git clone https://github.com/yourusername/justice-delivery-app.git```

## Setup virtual environment
```
python3 -m venv venv
#on Linux
source venv/bin/activate
#on Windows
venv\Scripts\activate
```
## Run Django server
The Django server was running on a different PC and flutter app on another to reduce load.
You can change your IP accordingly for requests to the server.
Just need to be connected to the same network.
```
python manage.py runserver 0.0.0.0:8000
```
## Flutter setup (frontend folder)
```
cd frontend
flutter pub get
flutter run
```
# Team
- [Bhuvan Goel](https://github.com/bhuvangoel04) – UI/UX, Backend & AI Integration

- Priyanshu Pandey(It's Me) – Flutter Dev,Backend & AI integration

