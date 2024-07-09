import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import ChatTranscriptRow from './ChatTranscriptRow'; // Assuming you have a component for each row
import Pagination from '../shared/Pagination';

function ChatTranscriptsList() {
    const [chatTranscripts, setChatTranscripts] = useState([]);

    useEffect(() => {
        fetchChatTranscripts();
    }, []);

    const fetchChatTranscripts = async () => {
        try {
            const response = await fetch('http://127.0.0.1:3000/chat_transcripts');
            if (!response.ok) {
                throw new Error('Failed to fetch data');
            }
            const data = await response.json();
            setChatTranscripts(data); // Assuming data is an array of chat transcripts
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    };


    return (
        <div>
            <h1>Chat Transcripts</h1>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Message</th>
                        {/* Add more headers as per your data structure */}
                    </tr>
                </thead>
                <tbody>
                    {chatTranscripts.map(transcript => (
                        <tr key={transcript.id}>
                            <td>{transcript.messaging_session_id}</td>
                            <td>{transcript.case_id}</td>
                            <td>{transcript.assigned_queue_name}</td>
                            <td>{transcript.assigned_officer}</td>
                            <td>{transcript.messaging_user}</td>
                            <td>{transcript.mop_phone_number}</td>
                            <td>{transcript.message}</td>
                            <td>{transcript.short_url}</td>
                            <td>{transcript.attachment}</td>
                            <td>{transcript.time}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default ChatTranscriptsList;