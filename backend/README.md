# Service Design Studio Final Project | Team 04 🚀

## Project Overview 📖
### CPF Text Us Humanless Audit

In this project, we were tasked to help the senior officers in CPF audit the scores of officers in CPF's Text Us Chatbot.
Our Aim is to grade Officers who manage the conversations on the CPF Text-Us Whatsapp platform, on a set of criterias using GenAI instead of having Senior Officers to grade the Officers.

### Problem Statement
How can we make the process of auditing chat transcripts less time consuming and unbiased whilst ensuring its results are consistently within the bandwidth of the audits made by a senior officer.


### Features ✨

- **Automated Auditing:** Automatically grades officers based on chat transcripts.
- **RESTful API:** Provides a set of endpoints for interacting with the system.
- **Google Cloud Vision Integration:** Uses Google Cloud Vision API to analyze text.
- **User Management:** Includes features for managing users and roles.
- **Case Management:** Allows creation and management of cases.
- **Chat Transcript Management:** Stores and retrieves chat transcripts.
- **AI-Audited Scores:** Submits and retrieves AI-audited scores.
- **Role-Based Access Control:** Ensures secure access based on user roles.
- **Reporting:** Generates reports on officer performance.


## Software Architecture 🏗️


- **Backend**: Built using Ruby on Rails, the backend provides a RESTful API for the frontend to interact with.
- **Frontend**: Developed with React, the frontend offers a seamless user experience.
- **Database**: The application uses a PostgreSQL database, hosted on Google Cloud SQL, designed to efficiently store and retrieve data.
- **LLM**: 

### Microservices

- **

### RESTful API

The application exposes a RESTful API to interact with the system. Below are some of the main API endpoints:

- `GET /api/v1/users` - Retrieve a list of users
- `POST /api/v1/cases` - Create a new case
- `GET /api/v1/chat_transcripts` - Retrieve chat transcripts
- `POST /api/v1/ai_audited_scores` - Submit AI-audited scores

### Database Design
The application uses a relational database to store data. The database schema is defined in the `db/schema.rb` file, and migrations are used to manage changes to the database structure.

#### Key Tables:
- `users` - Stores user information
- `cases` - Stores case details
- `chat_transcripts` - Stores chat transcripts
- `ai_audited_scores` - Stores AI-audited scores

## Google Cloud Platform (GCP) Integration ☁️

This project leverages several Google Cloud Platform services to enhance its capabilities:

- **Google Cloud SQL**: Hosts the PostgreSQL database, ensuring reliable and scalable data management.
- **Google Cloud Storage**: Stores media files and other static assets.


## Getting Started 🛠️

To get started, follow these instructions.

### Prerequisites

- **Ruby**: Ensure Ruby version 2.7.0 or later is installed.
- **Node.js** and **npm**: Required for running the frontend.
- **Cloud SQL Proxy**: For connecting to the Google Cloud SQL database.

### Installation

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-04.git
    cd 1d-final-project-summer-2024-sds-2024-team-04
    ```

2. **Setup Backend**:
    - **Install Dependencies**:
        ```bash
        cd backend
        bundle install
        ```
    - **Start Cloud SQL Proxy**:
        ```bash
        cloud_sql_proxy -instances=sign-ai:asia-southeast1:sign-ai-db=tcp:5432
        ```
    - **Start Backend Server**:
        ```bash
        bin/rails server
        ```

3. **Setup Frontend**:
    - **Install Dependencies**:
        ```bash
        cd frontend/sign-ai
        npm install
        ```
    - **Start Frontend Server**:
        ```bash
        npm start
        ```

### Running Tests

To run the Cucumber test cases for the frontend:

```bash
cd frontend/sign-ai
npm test



