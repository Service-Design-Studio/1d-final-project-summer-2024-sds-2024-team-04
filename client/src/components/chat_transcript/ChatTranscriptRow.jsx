import React from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

function ChatTranscriptRow({ transcript, onDelete }) {

    const handleDelete = async () => {
        const confirmDelete = window.confirm('Are you sure you want to delete this chat transcript?');

        if (confirmDelete) {
            try {
                await axios.delete(`http://localhost:3000/chat_transcripts/${transcript.id}`);
                onDelete(transcript.id);
            } catch (error) {
                console.error('Error deleting chat transcript:', error);
            }
        } else {
            return;
        }
    };

    return (
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
            <td>
                <Link to={`/chat_transcripts/${transcript.id}`} className="btn btn-primary">
                    View
                </Link>
                <button onClick={handleDelete} className="btn btn-danger ms-1">Delete</button>
            </td>
        </tr>
    );
}

export default ChatTranscriptRow;
