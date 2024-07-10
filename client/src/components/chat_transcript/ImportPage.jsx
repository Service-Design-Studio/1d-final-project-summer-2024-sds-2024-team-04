// ImportPage.jsx

import React, { useState } from 'react';
import axios from 'axios';

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
            alert(response.data.message || 'CSV imported successfully.');
        } catch (error) {
            console.error('Error importing CSV:', error.response?.data || error.message);
            alert(error.response?.data.error || 'Error importing CSV.');
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
