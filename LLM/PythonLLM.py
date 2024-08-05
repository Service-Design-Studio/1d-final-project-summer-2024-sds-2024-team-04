from flask import Flask, request, jsonify
import vertexai
from google.auth.transport.requests import Request
from google.oauth2.service_account import Credentials
from vertexai.language_models import TextGenerationModel

# Path to your service account key file
KEY_PATH = 'sds-cpf-429016-8b9ea9770c89.json'

# Initialize the Flask app
app = Flask(__name__)

# Set up Google Cloud credentials
credentials = Credentials.from_service_account_file(
    KEY_PATH,
    scopes=['https://www.googleapis.com/auth/cloud-platform']
)

if credentials.expired:
    credentials.refresh(Request())

# Set up project and region
PROJECT_ID = 'sds-cpf-429016'
REGION = 'us-central1'

# Initialize Vertex AI
vertexai.init(project=PROJECT_ID, location=REGION, credentials=credentials)

# Load the text generation model
generation_model = TextGenerationModel.from_pretrained("text-bison@001")

criteria_prompts = {
    "Accuracy of Information Provided": """
    Please review the following chat transcript and determine if the information provided by the agent is factually correct and matches the company's official documentation. Provide a PASS or FAIL based on this evaluation.

    Chat Transcript:
    {transcript}

    Evaluation Criteria:
    - Is the explanation accurate?
    - Are the details correct?
    - Is the information about procedures accurate?

    Result (PASS or FAIL):
    """,

    "Completeness of Responses": """
    Please review the following chat transcript and determine if the agent provided all necessary details to fully address the customer's query without omitting important information. Provide a PASS or FAIL based on this evaluation.

    Chat Transcript:
    {transcript}

    Evaluation Criteria:
    - Does the agent fully explain the issue?
    - Does the agent provide complete details about the procedures?
    - Does the agent check for and explain available options?

    Result (PASS or FAIL):
    """,

    "Timeliness of Responses": """
    Please review the following chat transcript and determine if the agent responded to the customer promptly, with minimal delays between exchanges. Provide a PASS or FAIL based on this evaluation.

    Chat Transcript:
    {transcript}

    Evaluation Criteria:
    - Does the agent respond promptly to the customer's query?
    - Are there minimal delays between the agent's responses?

    Result (PASS or FAIL):
    """,

    "Clarity and Understandability": """
    Please review the following chat transcript and determine if the agent's responses are clear, concise, and easy to understand for the customer. Provide a PASS or FAIL based on this evaluation.

    Chat Transcript:
    {transcript}

    Evaluation Criteria:
    - Are the agent's explanations clear?
    - Are the agent's responses concise and easy to understand?

    Result (PASS or FAIL):
    """,

    "Professionalism and Courtesy": """
    Please review the following chat transcript and determine if the agent maintained a professional tone and was courteous throughout the conversation. Provide a PASS or FAIL based on this evaluation.

    Chat Transcript:
    {transcript}

    Evaluation Criteria:
    - Does the agent use a professional tone?
    - Is the agent courteous throughout the conversation?

    Result (PASS or FAIL):
    """,

    "Adherence to Company Policies and Procedures": """
    Please review the following chat transcript and determine if the agent followed the company's policies and procedures accurately. Provide a PASS or FAIL based on this evaluation.

    Chat Transcript:
    {transcript}

    Evaluation Criteria:
    - Does the agent check the policy details as required?
    - Does the agent apply the procedures correctly?

    Result (PASS or FAIL):
    """,

    "Problem-Solving Ability": """
    Please review the following chat transcript and determine if the agent effectively addressed and resolved the customer's issues. Provide a PASS or FAIL based on this evaluation.

    Chat Transcript:
    {transcript}

    Evaluation Criteria:
    - Does the agent provide a satisfactory explanation for the issue?
    - Does the agent offer viable solutions to resolve the issue?

    Result (PASS or FAIL):
    """,

    "Use of Service-Oriented Language": """
    Please review the following chat transcript and determine if the agent used language that reflects a helpful and service-oriented attitude. Provide a PASS or FAIL based on this evaluation.

    Chat Transcript:
    {transcript}

    Evaluation Criteria:
    - Does the agent use language that reflects a willingness to help?
    - Does the agent offer additional assistance proactively?

    Result (PASS or FAIL):
    """,

    "Documentation and Record-Keeping": """
    Please review the following chat transcript and determine if the agent properly documented the conversation and any actions taken. Provide a PASS or FAIL based on this evaluation.

    Chat Transcript:
    {transcript}

    Evaluation Criteria:
    - Does the agent indicate that the actions will be recorded?
    - Is there evidence that the conversation and actions are properly documented?

    Result (PASS or FAIL):
    """
}

# Function to evaluate a criterion using Vertex AI's text generation model
def evaluate_criterion(criterion_name, prompt, transcript):
    formatted_prompt = prompt.format(transcript=transcript)
    response = generation_model.predict(formatted_prompt)
    result_text = response.text.strip()  # Assuming response.text contains the generated text
    # Extract the PASS or FAIL result from the response
    if "PASS" in result_text:
        result = "PASS"
    elif "FAIL" in result_text:
        result = "FAIL"
    else:
        result = "UNDETERMINED"
    return result

@app.route('/audit', methods=['POST'])
def audit_chat():
    data = request.json
    chat_transcript = data.get('whole_conversation', '')

    # Evaluate each criterion and store the results
    results = {}
    for criterion, prompt in criteria_prompts.items():
        results[criterion] = evaluate_criterion(criterion, prompt, chat_transcript)

    # Calculate the score based on the results
    score = sum(1 for result in results.values() if result == "PASS") / len(results) * 100

    # Create the final output as a JSON object
    final_output = {
        "criteria": {f"Criterion {i+1}": {"name": name, "result": result} for i, (name, result) in enumerate(results.items())},
        "score": score
    }

    return jsonify(final_output)

if __name__ == '__main__':
    app.run(debug=True)
