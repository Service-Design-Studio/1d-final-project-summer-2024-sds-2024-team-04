import React, {useState, useEffect} from 'react'

import { Row, Button, Alert, Col } from 'react-bootstrap'
import OverrideModal from './components/OverrideModal'
import Modal from 'react-bootstrap/Modal';
import Form from 'react-bootstrap/Form';
import { useNavigate, useParams } from 'react-router-dom'

import './AuditedCasesReview.css'

export default function AuditedCaseReview() {

    const navigate = useNavigate();
    const parms = useParams();
    const [isLoading, setIsLoading] = useState(false);
    const [cases, setCase] = useState(null)
    const [employee, setEmployee] = useState(null)
    const [aiAuditedScore, setAiAuditedScore] = useState(null)
    const [chatTranscript, setChatTranscript] = useState([])
    const [modalShow, setModalShow] = useState(false)
    const [editScore, setEditScore] = useState(null)
    const [comment, setComment] = useState('Some comments are here!')

    useEffect(() => {
        getCase();
    },[])

    useEffect(() => {
        if(aiAuditedScore !== null){
            setEditScore(aiAuditedScore.attributes)
        }
    },[aiAuditedScore])

    useEffect(() => {
        console.log(chatTranscript.length)
    },[chatTranscript])

    useEffect( () => {
        if(cases !== null){
            getEmployee()
            if(cases.relationships.ai_audited_score.data !== null){
                getAiAuditedScore()
            }
            setChatTranscript([])
            // cases.relationships.chat_transcript.data.forEach(chat => {
            //     getTranscript(chat.id)
            // });
            getTranscript()
        }
    },[cases])

    

    const getCase = () => {
        setIsLoading(true);
        const requestOptions = {
            method: "GET",
            redirect: "follow"
        };

        fetch(`http://127.0.0.1:3000/api/v1/cases/${parms.id}`, requestOptions)
            .then((respnse) => respnse.json())
            .then((response) => {
                console.log(JSON.stringify(response))
                setCase(response.data)
                setIsLoading(false)
            })
            .catch(() => {
                console.log("Unable to fetch cases!")
                setIsLoading(true)
            })
    }

    const getTranscript = async() => {
        var tempTrasncript = []
        setIsLoading(true);
        const requestOptions = {
            method: "GET",
            redirect: "follow"
        };

        for( const chat of cases.relationships.chat_transcript.data){
            const response = await fetch(`http://127.0.0.1:3000/api/v1/chat_transcripts/${chat.id}`, requestOptions)
            const responseJson = await response.json()
            tempTrasncript.push(responseJson.data)
            // setChatTranscript(transcript => [...transcript, responseJson.data])
        }
        setChatTranscript(tempTrasncript)

        // fetch(`http://127.0.0.1:3000/api/v1/chat_transcripts/${id}`, requestOptions)
        //     .then((respnse) => respnse.json())
        //     .then((response) => {
        //         console.log(JSON.stringify(response))
        //         setChatTranscript(transcript => [...transcript, response.data])
                
        //     })
        //     .catch(() => {
        //         console.log("Unable to fetch cases!")
        //         setIsLoading(true)
        //     })
    }

    const getAiAuditedScore = () => {
        setIsLoading(true);
        const requestOptions = {
            method: "GET",
            redirect: "follow"
        };

        fetch(`http://127.0.0.1:3000/api/v1/ai_audited_scores/${cases.relationships.ai_audited_score.data.id}`, requestOptions)
            .then((respnse) => respnse.json())
            .then((response) => {
                console.log(JSON.stringify(response))
                setAiAuditedScore(response.data)
                setIsLoading(false)
            })
            .catch(() => {
                console.log("Unable to fetch ai score!")
                setIsLoading(true)
            })
    }

    const getEmployee = () => {
        setIsLoading(true);
        const requestOptions = {
            method: "GET",
            redirect: "follow"
        };

        fetch(`http://127.0.0.1:3000/api/v1/employees/${cases.attributes.employee_id}`, requestOptions)
            .then((respnse) => respnse.json())
            .then((response) => {
                console.log(JSON.stringify(response))
                setEmployee(response.data)
                setIsLoading(false)
            })
            .catch(() => {
                console.log("Unable to fetch employee!")
                setIsLoading(true)
            })
    }

    const chatTranscriptList = chatTranscript.map((item, index) =>
        <div style={{width: '100%', textAlign: 'left', margin: '5px'}}>
            {`${item.attributes.messagingUser} : ${item.attributes.message}`}
        </div>
    )

  return (
    <div className='case_container'>
        <h2 style={{marginBottom: '20px'}}>Case Review</h2>
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
                            <h5>AI Audit Result</h5>
                            {
                                aiAuditedScore !== null ? 
                                <>
                                    <div className='result-wrap'>
                                        <div className='result' style={{fontWeight: 'bold'}}>Cirteria</div>
                                        <div className='result' style={{fontWeight: 'bold'}}>Satisfy/Unsatisfy</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result'>Cirteria1</div>
                                        <div className='result'>{aiAuditedScore.attributes.aiScore1 === true ? `Satisfy` : `Unsatisfy`}</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result'>Cirteria2</div>
                                        <div className='result'>{aiAuditedScore.attributes.aiScore2 === true ? `Satisfy` : `Unsatisfy`}</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result'>Cirteria3</div>
                                        <div className='result'>{aiAuditedScore.attributes.aiScore3 === true ? `Satisfy` : `Unsatisfy`}</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result'>Cirteria4</div>
                                        <div className='result'>{aiAuditedScore.attributes.aiScore4 === true ? `Satisfy` : `Unsatisfy`}</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result'>Cirteria5</div>
                                        <div className='result'>{aiAuditedScore.attributes.aiScore5 === true ? `Satisfy` : `Unsatisfy`}</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result'>Cirteria6</div>
                                        <div className='result'>{aiAuditedScore.attributes.aiScore6 === true ? `Satisfy` : `Unsatisfy`}</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result'>Cirteria7</div>
                                        <div className='result'>{aiAuditedScore.attributes.aiScore7 === true ? `Satisfy` : `Unsatisfy`}</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result'>Cirteria8</div>
                                        <div className='result'>{aiAuditedScore.attributes.aiScore8 === true ? `Satisfy` : `Unsatisfy`}</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result'>Cirteria9</div>
                                        <div className='result'>{aiAuditedScore.attributes.aiScore9 === true ? `Satisfy` : `Unsatisfy`}</div>
                                    </div>
                                    <div className='result-wrap'>
                                        <div className='result' style={{fontWeight: 'bold', fontSize: '22px'}}>Total</div>
                                        <div className='result' style={{fontWeight: 'bold', fontSize: '22px'}}>{aiAuditedScore.attributes.totalScore}%</div>
                                    </div>
                                    <div className='feedback-wrap'>
                                        <div style={{fontWeight: 'bold', fontSize: '18px'}}>Comment</div>
                                        <p >Some comments are here !!!</p>
                                    </div>
                                    <Button className='btn-override' onClick={() => setModalShow(true)}>Override Result</Button>
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
                        <div style={{width: '15%'}}>Cirteria1</div>
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
                        <div style={{width: '15%'}}>Cirteria2</div>
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
                        <div style={{width: '15%'}}>Cirteria3</div>
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
                        <div style={{width: '15%'}}>Cirteria4</div>
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
                        <div style={{width: '15%'}}>Cirteria5</div>
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
                        <div style={{width: '15%'}}>Cirteria6</div>
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
                        <div style={{width: '15%'}}>Cirteria7</div>
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
                        <div style={{width: '15%'}}>Cirteria8</div>
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
                        <div style={{width: '15%'}}>Cirteria9</div>
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
                        <Form.Control 
                            type="number" 
                            style={{width: '30%'}} 
                            value={editScore.totalScore} 
                            onChange={(e) => setEditScore((scores) => ({ ...scores, totalScore: e.target.value }))}
                        />
                    </div>
                    <div className='comment-wrap'>
                        <div style={{width: '15%'}}>Comment:</div>
                        <Form.Control 
                            as="textarea" 
                            rows={3} 
                            style={{width: '100%'}} 
                            value={comment}
                            onChange={(e) => setComment(e.target.value)}
                        />
                    </div>
                </div>
                }
                
            </Modal.Body>
            <Modal.Footer>
                <Button onClick={() => setModalShow(false)}>Submit</Button>
                <Button onClick={() => setModalShow(false)}>Close</Button>
            </Modal.Footer>
            </Modal>
    </div>
  )
}

