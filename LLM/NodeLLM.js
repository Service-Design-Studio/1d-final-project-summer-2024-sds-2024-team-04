const express = require('express');
const bodyParser = require('body-parser');
const { GoogleAuth } = require('google-auth-library');
const { VertexAI } = require('@google-cloud/vertexai');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());

// Path to your service account key file
const KEY_PATH = "C:\\Users\\khair\\github-classroom\\Service-Design-Studio\\1d-final-project-summer-2024-sds-2024-team-04\\LLM\\sds-cpf-429016-8b9ea9770c89.json";


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
    let outcome = "UNDETERMINED";
    if (resultText.includes("PASS")) {
      outcome = "PASS";
    } else if (resultText.includes("FAIL")) {
      outcome = "FAIL";
    }
    return outcome;
  } catch (error) {
    console.error("Error generating content:", error);
    return "ERROR";
  }
}

app.post('/audit', async (req, res) => {
  const data = req.body;
  const chatTranscript = data.whole_conversation || '';

  // Evaluate each criterion and store the results
  const results = {};
  for (const [criterion, prompt] of Object.entries(criteriaPrompts)) {
    results[criterion] = await evaluateCriterion(criterion, prompt, chatTranscript);
  }

  // Calculate the score based on the results
  const score = Object.values(results).filter(result => result === "PASS").length / Object.keys(results).length * 100;

  // Create the final output as a JSON object
  const finalOutput = {
    criteria: Object.entries(results).reduce((acc, [name, result], index) => {
      acc[`Criterion ${index + 1}`] = { name, result };
      return acc;
    }, {}),
    score
  };

  res.json(finalOutput);
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
