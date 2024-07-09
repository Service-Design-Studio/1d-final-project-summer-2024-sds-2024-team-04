import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import EmployeeList from './components/employees/EmployeeList';
import EmployeeDetails from './components/employees/EmployeeDetails';
import EmployeeNewForm from './components/employees/EmployeeNewForm';
import EmployeeEditForm from './components/employees/EmployeeEditForm';
import ChatTranscriptsList from './components/chat_transcript/ChatTranscriptsList';
import ChatTranscriptImport from './components/chat_transcript/ImportPage';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/employees" element={<EmployeeList />} />
        <Route path="/employees/:id" element={<EmployeeDetails />} />
        <Route path="/employees/new" element={<EmployeeNewForm />} />
        <Route path="/employees/:id/edit" element={<EmployeeEditForm />} />
        <Route path="/chat_transcripts" element={<ChatTranscriptsList />} />
        <Route path="/chat_transcripts/import" element={<ChatTranscriptImport />} />
        <Route path="/" element={<Home />} /> {/* Default route */}
      </Routes>
    </Router>
  );
}

function Home() {
  // Replace with your desired home page component
  return (
    <div>
      <h1>Welcome to My App</h1>
      <p>This is the default home page.</p>
    </div>
  );
}

export default App;
