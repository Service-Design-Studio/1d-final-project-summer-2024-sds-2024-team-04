import React, { useState, useEffect } from 'react';
import { Row, Button, Alert, Col } from 'react-bootstrap';
import OverrideModal from './components/OverrideModal';
import Modal from 'react-bootstrap/Modal';
import Form from 'react-bootstrap/Form';
import { useNavigate, useParams } from 'react-router-dom';
import './AuditedCasesReview.css';

export default function AuditedCaseReview() {
    const navigate = useNavigate();
    const parms = useParams();
    const [isLoading, setIsLoading] = useState(false);
<<<<<<< HEAD
    const [cases, setCase] = useState(null);
    const [employee, setEmployee] = useState(null);
    const [aiAuditedScore, setAiAuditedScore] = useState(null);
    const [chatTranscript, setChatTranscript] = useState([]);
    const [modalShow, setModalShow] = useState(false);
    const [editScore, setEditScore] = useState(null);
    const [comment, setComment] = useState('Some comments are here!');
=======
    const [cases, setCase] = useState(null)
    const [employee, setEmployee] = useState(null)
    const [aiAuditedScore, setAiAuditedScore] = useState(null)
    const [huAuditedScore, setHuAuditedScore] = useState(null)
    const [chatTranscript, setChatTranscript] = useState([])
    const [modalShow, setModalShow] = useState(false)
    const [editScore, setEditScore] = useState(null)
>>>>>>> origin/min-khant

    useEffect(() => {
        getCase();
    }, []);

    useEffect(() => {
<<<<<<< HEAD
        if (aiAuditedScore !== null) {
            setEditScore(aiAuditedScore.attributes);
=======
        if(aiAuditedScore !== null){
            setEditScore(aiAuditedScore.attributes)
            if(aiAuditedScore.relationships.human_audited_score.data.length !== 0){
                getHumanAuditedScore((aiAuditedScore.relationships.human_audited_score.data[aiAuditedScore.relationships.human_audited_score.data.length -1].id))
            }
>>>>>>> origin/min-khant
        }
    }, [aiAuditedScore]);

    useEffect(() => {
<<<<<<< HEAD
        console.log(chatTranscript.length);
    }, [chatTranscript]);
=======
        if(huAuditedScore !== null){
            setEditScore((scores) => ({ ...scores, aiScore1: huAuditedScore.attributes.huScore1 }))
            setEditScore((scores) => ({ ...scores, aiScore2: huAuditedScore.attributes.huScore2 }))
            setEditScore((scores) => ({ ...scores, aiScore3: huAuditedScore.attributes.huScore3 }))
            setEditScore((scores) => ({ ...scores, aiScore4: huAuditedScore.attributes.huScore4 }))
            setEditScore((scores) => ({ ...scores, aiScore5: huAuditedScore.attributes.huScore5 }))
            setEditScore((scores) => ({ ...scores, aiScore6: huAuditedScore.attributes.huScore6 }))
            setEditScore((scores) => ({ ...scores, aiScore7: huAuditedScore.attributes.huScore7 }))
            setEditScore((scores) => ({ ...scores, aiScore8: huAuditedScore.attributes.huScore8 }))
            setEditScore((scores) => ({ ...scores, aiScore9: huAuditedScore.attributes.huScore9 }))
            setEditScore((scores) => ({ ...scores, totalScore: huAuditedScore.attributes.huTotalScore }))
            setEditScore((scores) => ({ ...scores, aiFeedback: huAuditedScore.attributes.huFeedback }))
        }
    },[huAuditedScore])


    useEffect(() => {
        console.log(chatTranscript.length)
    },[chatTranscript])
>>>>>>> origin/min-khant

    useEffect(() => {
        if (cases !== null) {
            getEmployee();
            if (cases.relationships.ai_audited_score.data !== null) {
                getAiAuditedScore();
            }
            setChatTranscript([]);
            getTranscript();
        }
    }, [cases]);

    const getCase = () => {
        setIsLoading(true);
        const requestOptions = {
            method: 'GET',
            redirect: 'follow'
        };

        fetch(`http://127.0.0.1:3000/api/v1/cases/${parms.id}`, requestOptions)
            .then((response) => response.json())
            .then((response) => {
                console.log(JSON.stringify(response));
                setCase(response.data);
                setIsLoading(false);
            })
            .catch(() => {
                console.log('Unable to fetch cases!');
                setIsLoading(true);
            });
    };

<<<<<<< HEAD
    const getTranscript = async () => {
        var tempTranscript = [];
=======
    const getHumanAuditedScore = (id) => {
        setIsLoading(true);
        const requestOptions = {
            method: "GET",
            redirect: "follow"
        };

        fetch(`http://127.0.0.1:3000/api/v1/human_audited_scores/${id}`, requestOptions)
            .then((respnse) => respnse.json())
            .then((response) => {
                console.log(JSON.stringify(response))
                setHuAuditedScore(response.data)
                setIsLoading(false)
            })
            .catch(() => {
                console.log("Unable to fetch cases!")
                setIsLoading(true)
            })
    }

    const getTranscript = async() => {
        var tempTrasncript = []
>>>>>>> origin/min-khant
        setIsLoading(true);
        const requestOptions = {
            method: 'GET',
            redirect: 'follow'
        };

        for (const chat of cases.relationships.chat_transcript.data) {
            const response = await fetch(`http://127.0.0.1:3000/api/v1/chat_transcripts/${chat.id}`, requestOptions);
            const responseJson = await response.json();
            tempTranscript.push(responseJson.data);
        }
        setChatTranscript(tempTranscript);
    };

    const getAiAuditedScore = () => {
        setIsLoading(true);
        const requestOptions = {
            method: 'GET',
            redirect: 'follow'
        };

        fetch(`http://127.0.0.1:3000/api/v1/ai_audited_scores/${cases.relationships.ai_audited_score.data.id}`, requestOptions)
            .then((response) => response.json())
            .then((response) => {
                console.log(JSON.stringify(response));
                setAiAuditedScore(response.data);
                setIsLoading(false);
            })
            .catch(() => {
                console.log('Unable to fetch ai score!');
                setIsLoading(true);
            });
    };

    const updateAiAuditedScore = () => {
        const myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json")

        const raw = JSON.stringify({
            "isMadeCorrection": true
        })

        const requestOptions = {
            method: "PATCH",
            headers: myHeaders,
            body: raw,
            //redirect: "folllow"
        };

        fetch(`http://127.0.0.1:3000/api/v1/ai_audited_scores/${aiAuditedScore.id}`, requestOptions)
            .then((respnse) => respnse.json())
            .then((response) => {
                console.log(JSON.stringify(response))
                setAiAuditedScore(response.data)
                getAiAuditedScore()
                setIsLoading(false)
            })
            .catch(() => {
                console.log("Unable to update the result!")
                setIsLoading(true)
            })
    }

    const getEmployee = () => {
        setIsLoading(true);
        const requestOptions = {
            method: 'GET',
            redirect: 'follow'
        };

        fetch(`http://127.0.0.1:3000/api/v1/employees/${cases.attributes.employee_id}`, requestOptions)
            .then((response) => response.json())
            .then((response) => {
                console.log(JSON.stringify(response));
                setEmployee(response.data);
                setIsLoading(false);
            })
            .catch(() => {
                console.log('Unable to fetch employee!');
                setIsLoading(true);
            });
    };

<<<<<<< HEAD
    const chatTranscriptList = chatTranscript.map((item, index) => (
        <div className={`chat-message ${item.attributes.messagingUser === 'Officer' ? 'sent' : 'received'}`} key={index}>
            <div className="chat-user">{item.attributes.messagingUser}</div>
            <div className="chat-text">{item.attributes.message}</div>
=======
    const overrideResult = () => {
        const myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json")

        const raw = JSON.stringify({
            "huScore1": editScore.aiScore1,
            "huScore2": editScore.aiScore2,
            "huScore3": editScore.aiScore3,
            "huScore4": editScore.aiScore4,
            "huScore5": editScore.aiScore5,
            "huScore6": editScore.aiScore6,
            "huScore7": editScore.aiScore7,
            "huScore8": editScore.aiScore8,
            "huScore9": editScore.aiScore9,
            "huFeedback": editScore.aiFeedback,
            "huTotalScore": 80,
            "user_id": 1,
            "ai_audited_score_id": parseInt(aiAuditedScore.id)
        })

        console.log(raw)

        const requestOptions = {
            method: "POST",
            headers: myHeaders,
            body: raw,
            //redirect: "folllow"
        };

        fetch(`http://127.0.0.1:3000/api/v1/human_audited_scores`, requestOptions)
            .then((respnse) => respnse.json())
            .then((response) => {
                console.log(JSON.stringify(response))
                updateAiAuditedScore()
                setModalShow(false)
                setIsLoading(false)
            })
            .catch((response) => {
                console.log(response)
                setIsLoading(true)
            })
    }

    const chatTranscriptList = chatTranscript.map((item, index) =>
        <div style={{width: '100%', textAlign: 'left', margin: '5px'}}>
            {`${item.attributes.messagingUser} : ${item.attributes.message}`}
>>>>>>> origin/min-khant
        </div>
    ));

  return (
    <div className='case_container'>
            <button className='btn-back-dashboard' onClick={() => navigate('/dashboard')}> 
                Back to Dashboard
            </button>
            <h2 style={{ marginBottom: '20px' }}>Case Review</h2>
        {
            cases === null ? 
            <div>Loading....</div>:
            <div className='case-col-wrap'>
                <Col className='case-col'>
                    <div className='case-card'>
                        <h5>Chat Transcript</h5>
                        { chatTranscript.length > 0 ? chatTranscriptList : <div>No Chat Transcript!</div>}      
                    </div>  
                </Col>
                <Col className='case-col'>
                    <div className='case-card'>      
                        <div className='case-info-card'>
                            <h5>Case Information</h5>
                            <div className='info-wrap'>
                                <div className='info'>{`Case ID : ${cases.id}`}</div>
                                <div className='info'>{`Messaging Section: ${cases.attributes.messagingSection}`}</div>
                                <div className='info'>{`Contact No: ${cases.attributes.phoneNumber}`}</div>
                                <div className='info'>{`Topic: ${cases.attributes.topic}`}</div>
                                <div className='info'>Officer: {employee === null ? <></> : <>{employee.attributes.name}</>}</div>
                                <div className='info'>Status: {cases.attributes.status == 2 ? <>Completed</>: <>In Progress</>}</div>
                            </div>
                        </div>
                        <div className='result-card'>
                            <h5>Audit Result</h5>
                            {
                                aiAuditedScore !== null ? 
                                <>
                                    {
                                        huAuditedScore !== null ?
                                        <>
                                            <div className='result-wrap'>
                                                <div className='result' style={{fontWeight: 'bold'}}>Criteria</div>
                                                <div className='result' style={{fontWeight: 'bold'}}>Satisfy/Unsatisfy</div>
                                                {
                                                    aiAuditedScore.attributes.isMadeCorrection && 
                                                    <div className='result' style={{fontWeight: 'bold', color: 'blue'}}>Edited</div>
                                                }
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria1</div>
                                                <div className='result'>{huAuditedScore.attributes.huScore1 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria2</div>
                                                <div className='result'>{huAuditedScore.attributes.huScore2 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria3</div>
                                                <div className='result'>{huAuditedScore.attributes.huScore3 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria4</div>
                                                <div className='result'>{huAuditedScore.attributes.huScore4 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria5</div>
                                                <div className='result'>{huAuditedScore.attributes.huScore5 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria6</div>
                                                <div className='result'>{huAuditedScore.attributes.huScore6 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria7</div>
                                                <div className='result'>{huAuditedScore.attributes.huScore7 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria8</div>
                                                <div className='result'>{huAuditedScore.attributes.huScore8 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria9</div>
                                                <div className='result'>{huAuditedScore.attributes.huScore9 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result' style={{fontWeight: 'bold', fontSize: '22px'}}>Total</div>
                                                <div className='result' style={{fontWeight: 'bold', fontSize: '22px'}}>{huAuditedScore.attributes.huTotalScore}%</div>
                                            </div>
                                            <div className='feedback-wrap'>
                                                <div style={{fontWeight: 'bold', fontSize: '18px'}}>Comment</div>
                                                <p >{huAuditedScore.attributes.huFeedback}</p>
                                            </div>
                                            <Button className='btn-override' onClick={() => setModalShow(true)}>Override Result</Button>
                                        </>:
                                        <>
                                            <div className='result-wrap'>
                                                <div className='result' style={{fontWeight: 'bold'}}>Criteria</div>
                                                <div className='result' style={{fontWeight: 'bold'}}>Satisfy/Unsatisfy</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria1</div>
                                                <div className='result'>{aiAuditedScore.attributes.aiScore1 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria2</div>
                                                <div className='result'>{aiAuditedScore.attributes.aiScore2 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria3</div>
                                                <div className='result'>{aiAuditedScore.attributes.aiScore3 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria4</div>
                                                <div className='result'>{aiAuditedScore.attributes.aiScore4 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria5</div>
                                                <div className='result'>{aiAuditedScore.attributes.aiScore5 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria6</div>
                                                <div className='result'>{aiAuditedScore.attributes.aiScore6 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria7</div>
                                                <div className='result'>{aiAuditedScore.attributes.aiScore7 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria8</div>
                                                <div className='result'>{aiAuditedScore.attributes.aiScore8 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result'>Criteria9</div>
                                                <div className='result'>{aiAuditedScore.attributes.aiScore9 === true ? `Satisfy` : `Unsatisfy`}</div>
                                            </div>
                                            <div className='result-wrap'>
                                                <div className='result' style={{fontWeight: 'bold', fontSize: '22px'}}>Total</div>
                                                <div className='result' style={{fontWeight: 'bold', fontSize: '22px'}}>{aiAuditedScore.attributes.totalScore}%</div>
                                            </div>
                                            <div className='feedback-wrap'>
                                                <div style={{fontWeight: 'bold', fontSize: '18px'}}>Comment</div>
                                                <p >{aiAuditedScore.attributes.aiFeedback}</p>
                                            </div>
                                            <Button className='btn-override' onClick={() => setModalShow(true)}>Override Result</Button>
                                        </>
                                    }
                                </>:
                                <div>No audited result!</div>
                            }
                        </div>
                    </div>
                </Col>
            </div> 
        }
        {/* <OverrideModal
            show={modalShow}
            onHide={() => setModalShow(false)}
            aiScore={aiAuditedScore == null ? null : aiAuditedScore.attributes}
         /> */}
         <Modal
            show={modalShow}
            onHide={() => setModalShow(false)}
            size="lg"
            aria-labelledby="contained-modal-title-vcenter"
            centered
            scrollable
            >
            {/* <Modal.Header closeButton>
                <Modal.Title id="contained-modal-title-vcenter">
                Modal heading
                </Modal.Title>
            </Modal.Header> */}
            <Modal.Body 
            >
                <h5>Edit Audit Result</h5>
                <br></br>
                {
                    editScore !== null &&
                    <div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Criteria1</div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={editScore.aiScore1}
                                onChange={() => {
                                    setEditScore((scores) => ({ ...scores, aiScore1: true }))
                                }}
                            /> Satisfy
                        </div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={!editScore.aiScore1}
                                onChange={() => {
                                    setEditScore((scores) => ({ ...scores, aiScore1: false }))
                                }}
                            /> Unsatisfy
                        </div>
                    </div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Criteria2</div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={editScore.aiScore2}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore2: true }))}
                            /> Satisfy
                        </div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={!editScore.aiScore2}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore2: false }))}
                            /> Unsatisfy
                        </div>
                    </div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Criteria3</div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={editScore.aiScore3}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore3: true }))}
                            /> Satisfy
                        </div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={!editScore.aiScore3}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore3: false }))}
                            /> Unsatisfy
                        </div>
                    </div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Criteria4</div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={editScore.aiScore4}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore4: true }))}
                            /> Satisfy
                        </div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={!editScore.aiScore4}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore4: false }))}
                            /> Unsatisfy
                        </div>
                    </div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Criteria5</div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={editScore.aiScore5}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore5: true }))}
                            /> Satisfy
                        </div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={!editScore.aiScore5}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore5: false }))}
                            /> Unsatisfy
                        </div>
                    </div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Criteria6</div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={editScore.aiScore6}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore6: true }))}
                            /> Satisfy
                        </div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={!editScore.aiScore6}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore6: false }))}
                            /> Unsatisfy
                        </div>
                    </div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Criteria7</div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={editScore.aiScore7}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore7: true }))}
                            /> Satisfy
                        </div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={!editScore.aiScore7}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore7: false }))}
                            /> Unsatisfy
                        </div>
                    </div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Criteria8</div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={editScore.aiScore8}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore8: true }))}
                            /> Satisfy
                        </div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={!editScore.aiScore8}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore8: false }))}
                            /> Unsatisfy
                        </div>
                    </div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Criteria9</div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={editScore.aiScore9}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore9: true }))}
                            /> Satisfy
                        </div>
                        <div style={{width: '15%'}}>
                            <input
                                type="radio"
                                checked={!editScore.aiScore9}
                                onChange={() => setEditScore((scores) => ({ ...scores, aiScore9: false }))}
                            /> Unsatisfy
                        </div>
                    </div>
                    <div className='radio-wrap'>
                        <div style={{width: '15%'}}>Total:</div>
                        <div style={{width: '30%'}}>{editScore.totalScore} % </div>
                    </div>
                    <div className='comment-wrap'>
                        <div style={{width: '15%'}}>Comment:</div>
                        <Form.Control 
                            as="textarea" 
                            rows={3} 
                            style={{width: '100%'}} 
                            value={editScore.aiFeedback}
                            onChange={(e) => setEditScore((scores) => ({ ...scores, aiFeedback: e.target.value }))}
                        />
                    </div>
                </div>
                }
                
            </Modal.Body>
            <Modal.Footer>
                <Button onClick={() => overrideResult()}>Submit</Button>
                <Button onClick={() => setModalShow(false)}>Close</Button>
            </Modal.Footer>
            </Modal>
    </div>
  )
}

