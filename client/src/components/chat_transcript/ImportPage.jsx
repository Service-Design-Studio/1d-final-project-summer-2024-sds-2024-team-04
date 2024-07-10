// ImportPage.jsx

import React, { useState } from 'react';
import axios from 'axios'; // Use axios or fetch for HTTP requests

const ImportPage = () => {
    const [selectedFile, setSelectedFile] = useState(null);

    const handleFileChange = (event) => {
        setSelectedFile(event.target.files[0]);
    };

    const handleFileUpload = async () => {
        if (!selectedFile) {
            alert('Please select a file.');
            return;
        }

        try {
            const formData = new FormData();
            formData.append('file', selectedFile);

            const response = await axios.post('http://localhost:3000/chat_transcripts/import', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            });

            console.log(response.data); // Handle success response
            alert('CSV imported successfully.');
        } catch (error) {
            console.error('Error importing CSV:', error);
            alert('Error importing CSV.');
        }
    };

    return (
        <div>
            <h1>Import Chat Transcripts</h1>
            <input type="file" onChange={handleFileChange} />
            <button onClick={handleFileUpload}>Import CSV</button>
        </div>
    );
};

export default ImportPage;
