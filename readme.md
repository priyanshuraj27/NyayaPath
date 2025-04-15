# Nyayapath
An AI-powered mobile application designed to simplify and accelerate access to justice. Built during a hackathon, this app helps users understand their legal issues through natural language queries, provides AI-generated summaries of legal texts, and guides them through appropriate legal pathways.

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
### AI-powered Intent Classifier using TensorFlow Lite

### Legal Summarizer model optimized for mobile using TFLite

### Query History & Secure Storage

### Multilingual Support (coming soon)

### Secure backend with Django API

### Tech Stack

Component	Tech Used
Frontend	Flutter
Backend	Django REST Framework
AI/ML Models	TensorFlow Lite (Intent & Summary)
Summarization	Custom trained T5-based model
Deployment	Hosted on LAN/Local for Hackathon Demo
Database	SQLite (Dev) / PostgreSQL (Prod)
## Why This is Needed (Stats)
India has 4.7 crore pending court cases (as of 2023)

Only 5-10% of Indians have basic legal knowledge

Average time for civil case resolution: 13+ years

Rural users face language barriers, lack of awareness, and poor internet connectivity

## Challenges We Faced
Integrating TensorFlow Lite models in Django

Handling CSRF issues and cross-device communication

Summarizing large legal documents with limited memory

Model size optimizations for mobile devices

Dynamic IP management during app testing

#Demo
Add screenshots or GIFs here
## Setup Instructions
bash
Copy
Edit
# Clone the repo
git clone https://github.com/yourusername/justice-delivery-app.git

# Setup virtual environment
python3 -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows

# Install backend dependencies
pip install -r requirements.txt

# Run Django server
python manage.py runserver 0.0.0.0:8000

# Flutter setup (frontend folder)
cd frontend
flutter pub get
flutter run

## Team
- [Bhuvan Goel](https://github.com/bhuvangoel04) – UI/UX, Backend & AI Integration

Priyanshu Pandey(It's Me) – Flutter Dev

