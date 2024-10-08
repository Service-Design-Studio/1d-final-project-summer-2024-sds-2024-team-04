const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const { VertexAI } = require('@google-cloud/vertexai');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(bodyParser.json());

// Path to your service account key file
const KEY_PATH = path.join(__dirname, 'sds-cpf-429016-869c0f7d5aaa.json');

const projectId = "sds-cpf-429016";
const location = "us-central1";

// Initialize Vertex AI client
let model;
async function initializeVertexAI() {
  const auth = new GoogleAuth({
    keyFile: KEY_PATH,
    scopes: ['https://www.googleapis.com/auth/cloud-platform']
  });

  const authClient = await auth.getClient();

  const vertexAI = new VertexAI({ project: projectId, location: location, authClient });

  model = await vertexAI.preview.getGenerativeModel({ model: "gemini-pro" });
}

initializeVertexAI();

// Define the criteria and corresponding prompts
const criteriaPrompts = {
  "Accuracy of Information Provided": `
  Please review the following chat transcript and determine if the information provided by the agent is factually correct and matches the company's official documentation. Provide a PASS or FAIL based on this evaluation.

  Chat Transcript:
  {transcript}

  Evaluation Criteria:
  - Is the explanation accurate?
  - Are the details correct?
  - Is the information about procedures accurate?

  Result (PASS or FAIL):
  `,

  "Completeness of Responses": `
  Please review the following chat transcript and determine if the agent provided all necessary details to fully address the customer's query without omitting important information. Provide a PASS or FAIL based on this evaluation.

  Chat Transcript:
  {transcript}

  Evaluation Criteria:
  - Does the agent fully explain the issue?
  - Does the agent provide complete details about the procedures?
  - Does the agent check for and explain available options?

  Result (PASS or FAIL):
  `,

  "Timeliness of Responses": `
  Please review the following chat transcript and determine if the agent responded to the customer promptly, with minimal delays between exchanges. Provide a PASS or FAIL based on this evaluation.

  Chat Transcript:
  {transcript}

  Evaluation Criteria:
  - Does the agent respond promptly to the customer's query?
  - Are there minimal delays between the agent's responses?

  Result (PASS or FAIL):
  `,

  "Clarity and Understandability": `
  Please review the following chat transcript and determine if the agent's responses are clear, concise, and easy to understand for the customer. Provide a PASS or FAIL based on this evaluation.

  Chat Transcript:
  {transcript}

  Evaluation Criteria:
  - Are the agent's explanations clear?
  - Are the agent's responses concise and easy to understand?

  Result (PASS or FAIL):
  `,

  "Professionalism and Courtesy": `
  Please review the following chat transcript and determine if the agent maintained a professional tone and was courteous throughout the conversation. Provide a PASS or FAIL based on this evaluation.

  Chat Transcript:
  {transcript}

  Evaluation Criteria:
  - Does the agent use a professional tone?
  - Is the agent courteous throughout the conversation?

  Result (PASS or FAIL):
  `,

  "Adherence to Company Policies and Procedures": `
  Please review the following chat transcript and determine if the agent followed the company's policies and procedures accurately. Provide a PASS or FAIL based on this evaluation.

  Chat Transcript:
  {transcript}

  Evaluation Criteria:
  - Does the agent check the policy details as required?
  - Does the agent apply the procedures correctly?

  Result (PASS or FAIL):
  `,

  "Problem-Solving Ability": `
  Please review the following chat transcript and determine if the agent effectively addressed and resolved the customer's issues. Provide a PASS or FAIL based on this evaluation.

  Chat Transcript:
  {transcript}

  Evaluation Criteria:
  - Does the agent provide a satisfactory explanation for the issue?
  - Does the agent offer viable solutions to resolve the issue?

  Result (PASS or FAIL):
  `,

  "Use of Service-Oriented Language": `
  Please review the following chat transcript and determine if the agent used language that reflects a helpful and service-oriented attitude. Provide a PASS or FAIL based on this evaluation.

  Chat Transcript:
  {transcript}

  Evaluation Criteria:
  - Does the agent use language that reflects a willingness to help?
  - Does the agent offer additional assistance proactively?

  Result (PASS or FAIL):
  `,

  "Documentation and Record-Keeping": `
  Please review the following chat transcript and determine if the agent properly documented the conversation and any actions taken. Provide a PASS or FAIL based on this evaluation.

  Chat Transcript:
  {transcript}

  Evaluation Criteria:
  - Does the agent indicate that the actions will be recorded?
  - Is there evidence that the conversation and actions are properly documented?

  Result (PASS or FAIL):
  `,

  "Customer Service Feedback": `
  Please provide overall feedback on the customer service agent's performance based on the following chat transcript. Include strengths and areas for improvement.

  Chat Transcript:
  {transcript}

  Overall Feedback:
  `
};

// Function to evaluate a criterion using Vertex AI's text generation model
async function evaluateCriterion(criterionName, prompt, transcript) {
  const formattedPrompt = prompt.replace('{transcript}', transcript);
  const request = {
    contents: [{ role: "user", parts: [{ text: formattedPrompt }] }],
  };

  try {
    const result = await model.generateContent(request);
    const resultText = result.response.candidates[0].content.parts[0].text.trim();
    return resultText;  // Return the full feedback text instead of just "PASS" or "FAIL"
  } catch (error) {
    console.error("Error generating content:", error);
    return "ERROR";
  }
}

async function processCases() {
  try {
    const response = await axios.get('https://sds-cpf-audit-kr3vrf23oq-as.a.run.app/api/v1/unaudited_cases'); // Change this to the appropriate endpoint
    const data = response.data;

    // Check if data is empty or contains no cases
    if (!data.data || data.data.length === 0) {
      console.log('No cases to process');
      return;
    }

    for (const caseData of data.data) {
      const chatTranscriptArray = data.included
        .filter(item => item.type === 'chat_transcript' && item.attributes.case_id === parseInt(caseData.id))
        .map(item => item.attributes.message);

      const chatTranscript = chatTranscriptArray.join('\n');
      const caseId = caseData.id;

      // Update the case status to 1 before processing
      try {
        const putResponse = await axios.put(`https://sds-cpf-audit-kr3vrf23oq-as.a.run.app/api/v1/cases/${caseId}`, {
          case: {
            status: 1
          }
        });
        console.log('PUT response for status 1:', putResponse.data);
      } catch (error) {
        console.error('Error updating case status to 1:', error);
        continue; // Skip this case and proceed with the next one
      }

      // Evaluate each criterion and store the results
      const results = {};
      const feedback = {};  // To store detailed feedback for each criterion
      for (const [criterion, prompt] of Object.entries(criteriaPrompts)) {
        const feedbackText = await evaluateCriterion(criterion, prompt, chatTranscript);
        feedback[criterion] = feedbackText;
        results[criterion] = feedbackText.includes("PASS");
      }

      // Generate overall feedback based on the criteria results
      const overallFeedback = feedback["Customer Service Feedback"];

      // Calculate the score based on the results and round to the nearest whole number
      const score = Math.round(Object.values(results).filter(result => result === true).length / Object.keys(results).length * 100);

      // Create the final output as a JSON object in the specified format
      const finalOutput = {
        ai_audited_score: {
          aiScore1: results["Accuracy of Information Provided"],
          aiScore2: results["Completeness of Responses"],
          aiScore3: results["Timeliness of Responses"],
          aiScore4: results["Clarity and Understandability"],
          aiScore5: results["Professionalism and Courtesy"],
          aiScore6: results["Adherence to Company Policies and Procedures"],
          aiScore7: results["Problem-Solving Ability"],
          aiScore8: results["Use of Service-Oriented Language"],
          aiScore9: results["Documentation and Record-Keeping"],
          aiFeedback: Object.entries(feedback).map(([criterion, text]) => `${criterion} Feedback:\n${text}`).join('\n\n'),
          totalScore: score,
          isMadeCorrection: false,
          case_id: caseId
        }
      };

      try {
        // Send POST request to save the score
        const postResponse = await axios.post('https://sds-cpf-audit-kr3vrf23oq-as.a.run.app/api/v1/ai_audited_scores', finalOutput);
        console.log('POST response:', postResponse.data);

        // Send PUT request to update the case status to 2
        const putResponse2 = await axios.put(`https://sds-cpf-audit-kr3vrf23oq-as.a.run.app/api/v1/cases/${caseId}`, {
          case: {
            status: 2
          }
        });
        console.log('PUT response for status 2:', putResponse2.data);

      } catch (error) {
        console.error('Error during API requests:', error);
      }
    }
  } catch (error) {
    console.error('Error fetching cases:', error);
  }
}

// Schedule the function to run every minute
setInterval(processCases, 60000);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});