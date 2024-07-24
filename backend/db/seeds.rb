# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
roles = Role.create([
    {
        name: "Senior Officer",
        description: "Senior Officer audit the cases."
    },
    {
        name: "Officer",
        description: "Officer responds the customers"
    }
])

employees = Employee.create([
    {
        name: "Calvin",
        email: "calvin@gmail.com",
        contact_no: "+6533333333",
        role: roles.first
    },
    {
        name: "Daniel",
        email: "daniel@gmail.com",
        contact_no: "+6534343434",
        role: roles.first
    },
    {
        name: "Theo",
        email: "theo@gmail.com",
        contact_no: "+6557565656",
        role: roles.second
    },
    {
        name: "Gethin",
        email: "gethin@gmail.com",
        contact_no: "+6587878459",
        role: roles.second
    }
])

users = User.create([
    {
        username: "calvin@gmail.com",
        password: "123456",
        employee: employees.first
    },
    {
        username: "daniel@gmail.com",
        password: "123456",
        employee: employees.second
    }
])

cases = Case.create([
    {
        messagingSection: "M23445453",
        phoneNumber: "+6523434534",
        topic: "MediSave",
        status: 2,
        employee: employees.third
    },
    {
        messagingSection: "M34343344",
        phoneNumber: "+6534989973",
        topic: "MediSave",
        status: 0,
        employee: employees.fourth
    }
])

chat_transcript = ChatTranscript.create([
    {
        messagingUser: "Mr.Lim",
        message: "Hello",
        case: cases.first
    },
    {
        messagingUser: "Officer",
        message: "Hello, I am CPF officer. How can I help you?",
        case: cases.first
    },
    {
        messagingUser: "Mr.Lim",
        message: "I would like to enquiry about the Medi Save. What is MediSave.",
        case: cases.first
    },
    {
        messagingUser: "Officer",
        message: "Oh. Yes. It is your personal healthcare savings acount.When you’re working, you save between 8% and 10.5% of your monthly salary in your MediSave.This helps you pay for your healthcare expenses over your lifetime, especially when you retire and no longer have a regular income.",
        case: cases.first
    },
    {
        messagingUser: "Mr.Lim",
        message: "Oh. Ok. Thanks. That's all.",
        case: cases.first
    },
    {
        messagingUser: "Officer",
        message: "Your are welcome.",
        case: cases.first
    },
    {
        messagingUser: "Ms.Boey",
        message: "Hello",
        case: cases.second
    },
    {
        messagingUser: "Officer",
        message: "Hello, I am CPF officer. How can I help you?",
        case: cases.second
    },
    {
        messagingUser: "Ms.Boey",
        message: "I would like to enquiry about theBasic Healthcare Sum. What is Basic Healthcare Sum.",
        case: cases.second
    },
    {
        messagingUser: "Officer",
        message: "our BHS is the estimated amount of savings you need for basic subsidised healthcare expenses in old age. It is the maximum amount you can have in your MediSave.Your BHS is adjusted yearly until you reach the age of 65 and will remain fixed for the rest of your life.",
        case: cases.second
    },
    {
        messagingUser: "Ms.Boey",
        message: "Oh. Ok. Thanks. That's all.",
        case: cases.second
    },
    {
        messagingUser: "Officer",
        message: "Your are welcome.",
        case: cases.second
    }
])

ai_audited_scores = AiAuditedScore.create([
    {
        aiScore1: true,
        aiScore2: true,
        aiScore3: true,
        aiScore4: true,
        aiScore5: false,
        aiScore6: true,
        aiScore7: false,
        aiScore8: true,
        aiScore9: true,
        aiFeedback: "Some Comments are here!!!!",
        totalScore: 80,
        isMadeCorrection: false,
        case: cases.first
    } 
])