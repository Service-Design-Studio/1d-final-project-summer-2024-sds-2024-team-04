# Service Design Studio Final Project | Team 04 🚀

## Project Overview 📖
### CPF Text Us Humanless Audit
In this project, our Aim is to grade team members who manage the conversations on the CPF Text-Us Whatsapp platform, on a set of criterias using GenAI instead of having Senior Officers to grade the Officers.

### Problem Statement
How can we make the process of auditing chat transcripts less time consuming and unbiased whilst ensuring its results are consistently within the bandwidth of the audits made by a senior officer.

## Software Architecture 🏗️
![image](https://github.com/user-attachments/assets/a1bbfa8e-f28b-4e63-8009-d6891ca41521)



### RESTful API

The application exposes a RESTful API to interact with the system. Below are some of the main API endpoints:

- `GET /api/v1/users` - Retrieve a list of users
- `POST /api/v1/cases` - Create a new case
- `GET /api/v1/chat_transcripts` - Retrieve chat transcripts
- `POST /api/v1/ai_audited_scores` - Submit AI-audited scores

### Database Design
The application uses a relational database to store data. The database schema is defined in the `db/schema.rb` file, and migrations are used to manage changes to the database structure.

#### Key Tables:
- `user` - Stores user information
- `case` - Stores case details
- `chat_transcript` - Stores chat transcripts
- `ai_audited_score` - Stores AI-audited scores
- `human_audited_score` - Stores Human-audited scores
- `audit_criteria` - Stores Grading Criterias

![image](https://github.com/user-attachments/assets/10304e98-dd7d-497f-838f-62c2fcf14bf0)



## Getting Started 🛠️

To get started, follow these instructions.

### Prerequisites

- **Ruby**: Ensure Ruby version 3.3.3 is installed.
- **PostgreSQL**:  Ensure PostgreSQL version 16 is installed.
- **Node.js** and **npm**: Required for running the frontend.
- **Cloud SQL Proxy**: For connecting to the Google Cloud SQL database.

### Installation

1. **Clone the Repository**:
    ```terminal
    git clone https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-04.git
    cd 1d-final-project-summer-2024-sds-2024-team-04
    ```

3. **Setup Backend**:
    - **Install Dependencies**:
        ```powershell
        cd backend
        bundle install
        ```
    - **Setup Database**:
      1. Locate "database.yml" under cd backend, change line 22 "password: admin" to "password: //your SQL shell password" and save it.
      2. ```powershell
           rails db:create
           rails db:migrate
           rails db:seed
         ```
        3. Check for updates of the database in SQL shell if needed.

    - **Start Backend Server**:
        ```powershell
        rails s
        ```

4. **Setup Frontend**:
    - **Install Dependencies**:
        ```bash
        cd client
        npm install
        ```
    - **Start Frontend Server**:
        ```bash
        npm start
        ```

### Running Tests

To run the Cucumber test cases:

```powershell
    bundle exec cucumber
```

Figma workspace: https://www.figma.com/board/cyGs0bhwER0a71wbtdka51/SDS---TEAM-4?node-id=0-1&t=UeGymPbo35stEZI9-0

Design Workbook: https://docs.google.com/document/d/1Qb29k2Jnj6Hm_jT6p0B45qDgfmPALOdiLaQqKrqY7IU/edit
