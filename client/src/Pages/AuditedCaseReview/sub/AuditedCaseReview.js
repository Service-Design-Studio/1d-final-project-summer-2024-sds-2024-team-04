import React, {useState, useEffect} from 'react'

import { Row, Button, Alert, Col } from 'react-bootstrap'
import Form from 'react-bootstrap/Form'
import { useNavigate, useParams } from 'react-router-dom'

import './AuditedCasesReview.css'

export default function AuditedCaseReview() {

    const navigate = useNavigate();
    const parms = useParams();
    const [isLoading, setIsLoading] = useState(false);
    const [cases, setCase] = useState(null)
    const [employee, setEmployee] = useState(null)
    const [aiAuditedScore, setAiAuditedScore] = useState(null)

    useEffect(() => {
        getCase();
    },[])

    useEffect(() => {
        if(cases !== null){
            getEmployee()
            if(cases.relationships.ai_audited_score.data !== null){
                getAiAuditedScore()
            }
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
                                </>:
                                <div>No audited result!</div>
                            }
                            
                        </div>
                    </div>
                </Col>
            </div> 
        }
    </div>
  )
}

