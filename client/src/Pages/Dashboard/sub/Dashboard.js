//Libraries
import React, {useState, useEffect} from 'react'
import moment from 'moment'

//Component
import { Col } from 'react-bootstrap'
import { useNavigate } from 'react-router-dom'

//CSS
import './Dashboard.css'

const Dashboard = () => {

    const navigate = useNavigate();
    const [isLoading, setIsLoading] = useState(false);
    const [cases, setCases] = useState([])
    const [aiAuditedScore, setAiAuditedScore] = useState([])
    const [totalAuditedCase, setTotalAuditedCase] = useState(0)
    const [averageScore, setAverageScore] = useState(0)
    const [unAuditedCases, setUnauditedCases] = useState([])
    const [auditedCases, setAuditedCases] = useState([])
    const [searchBy, setSearchBy] = useState('ID');
    const [searchInput, setSearchInput] = useState('');


    useEffect(() => {
        getCases()
        getAiAuditedScore()

    },[])

    useEffect(() => {
        cases.forEach((item) => {
            if(item.attributes.status == 0){
                setUnauditedCases(unAuditedCases => [...unAuditedCases, item])
            }
            else{
                setAuditedCases(auditedCases => [...auditedCases, item])
            }
        })
    },[cases])

    useEffect(() => {
        console.log(aiAuditedScore)
        setTotalAuditedCase(aiAuditedScore.length)
        findAverageScore()
    },[aiAuditedScore])

    
    const getCases = () => {
        setIsLoading(true);
        const requestOptions = {
            method: "GET",
            redirect: "follow"
        };

        fetch("http://127.0.0.1:3000/api/v1/cases", requestOptions)
            .then((respnse) => respnse.json())
            .then((response) => {
                //console.log(JSON.stringify(response))
                setUnauditedCases([])
                setAuditedCases([])
                setCases(response.data)
                setIsLoading(false)
            })
            .catch(() => {
                console.log("Unable to fetch cases!")
                setIsLoading(true)
            })
    }

    const getEmployee = (id) => {
        setIsLoading(true);
        const requestOptions = {
            method: "GET",
            redirect: "follow"
        };

        fetch(`http://127.0.0.1:3000/api/v1/employees/${id}`, requestOptions)
            .then((respnse) => respnse.json())
            .then((response) => {
                console.log(JSON.stringify(response))

                setCases(response.data)
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

        fetch("http://127.0.0.1:3000/api/v1/ai_audited_scores", requestOptions)
            .then((respnse) => respnse.json())
            .then((response) => {
                console.log(JSON.stringify(response))
                getCases()
                setAiAuditedScore(response.data)
                setIsLoading(false)
            })
            .catch(() => {
                console.log("Unable to fetch cases!")
                setIsLoading(true)
            })
    }

    const findAverageScore = () =>{
        var sum = 0
        aiAuditedScore.forEach((audit) => {
            console.log(audit.totalScore)
            sum += audit.attributes.totalScore
        })
        console.log(`sum: ${sum}`)
        setAverageScore(sum/aiAuditedScore.length)
    }

    const audit = ({item}) => {
        console.log("Audit funtion id called")
        const myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json");

        const raw = JSON.stringify({
        "status": 1
        });

        const requestOptions = {
            method: "PATCH",
            headers: myHeaders,
            body: raw,
            redirect: "follow"
        };

        fetch(`http://127.0.0.1:3000/api/v1/cases/${item.id}`, requestOptions)
        .then((respnse) => respnse.json())
        .then((response) => {
            console.log(JSON.stringify(response))
            getCases()
        })
        .catch(() => {
            console.log("Unable to update the cases!")
            setIsLoading(true)
        })
    }

    //add filter
    const filteredCases = cases.filter((item) => {
        const searchLower = searchInput.toLowerCase();
        switch (searchBy) {
            case 'ID':
                return item.id.toString().includes(searchInput);
            case 'Section':
                return item.attributes.messagingSection.toLowerCase().includes(searchLower);
            case 'Officer':
                return item.attributes.employee_id.toString().includes(searchInput);
            case 'Topic':
                return item.attributes.topic.toLowerCase().includes(searchLower);
            default:
                return true;
        }
    });


    const unAuditedCasecardList = filteredCases.filter(item => item.attributes.status === 0).map((item, index) => (
        <div className="dash-case-warp" key={index} onClick={() => navigate(`/auditedcasereview/${item.id}`)}>
            <div style={{ width: "5%" }}>{item.id}</div>
            <div style={{ width: "15%" }}>{item.attributes.messagingSection}</div>
            <div style={{ width: "15%" }}>{`OfficerID: ${item.attributes.employee_id}`}</div>
            <div style={{ width: "15%" }}>{item.attributes.topic}</div>
            <div style={{ width: "25%" }}>
                {moment(item.attributes.created_at).format("MMMM DD YYYY, HH:mm:ss")}
            </div>
            <div className="status-in-progress">In Progress</div>
        </div>
    ));

    const auditedCasecardList = filteredCases.filter(item => item.attributes.status !== 0).map((item, index) => (
        <div className="dash-case-warp" key={index} onClick={() => navigate(`/auditedcasereview/${item.id}`)}>
            <div style={{ width: "5%" }}>{item.id}</div>
            <div style={{ width: "15%" }}>{item.attributes.messagingSection}</div>
            <div style={{ width: "15%" }}>{`OfficerID: ${item.attributes.employee_id}`}</div>
            <div style={{ width: "15%" }}>{item.attributes.topic}</div>
            <div style={{ width: "25%" }}>
                {moment(item.attributes.created_at).format("MMMM DD YYYY, HH:mm:ss")}
            </div>
            {
                item.attributes.status == 1 ?
                <div style={{ backgroundColor: "rgba(255, 240, 0, 0.4)", padding: "3px", borderRadius: '5px', width: '15%'}}>In Progress</div> :
                <div style={{ backgroundColor: "rgba(0, 255, 0, 0.4)", padding: "3px", borderRadius: '5px', width: '15%'}}>Completed</div>
            }
        </div>
    ));
    

  return (
    <div className="dashboard_container">
            <h2 style={{ marginBottom: "20px" }}>Dashboard</h2>
            {isLoading ? (
                <div className="loading">Loading...</div>
            ) : (
                <div className="dash-col-wrap">
                    <Col className="dash-col">
                        <div className="first-group" style={{ padding: "0px" }}>
                            <div className="dash-card-one">
                                <div className="dash-text-one">Total Cases</div>
                                <div className="dash-text-two">{cases.length}</div>
                            </div>
                            <div className="dash-card-one">
                                <div className="dash-text-one">Total Audited Cases</div>
                                <div className="dash-text-two">{totalAuditedCase}</div>
                            </div>
                            <div className="dash-card-one">
                                <div className="dash-text-one">Average Score</div>
                                <div className="dash-text-two">{`${averageScore}%`}</div>
                            </div>
                        </div>
                        <div className="dash-card-four">
                            <div className="dash-text-one">Recent Audits</div>
                            <div className="search-bar-container" style={{ display: 'flex', justifyContent: 'center', marginBottom: '20px' }}>
                                <select
                                    className="search-dropdown"
                                    value={searchBy}
                                    onChange={(e) => setSearchBy(e.target.value)}
                                    style={{ marginRight: '10px' }}
                                >
                                    <option value="ID">ID</option>
                                    <option value="Section">Section</option>
                                    <option value="Officer">Officer</option>
                                    <option value="Topic">Topic</option>
                                </select>
                                <input
                                    className="search-bar"
                                    type="text"
                                    value={searchInput}
                                    onChange={(e) => setSearchInput(e.target.value)}
                                    placeholder={`Search by ${searchBy}`}
                                    style={{ width: '200px' }}
                                />
                            </div>
                            <div className="dash-case-title-warp">
                                <div style={{ width: "5%" }}>ID</div>
                                <div style={{ width: "15%" }}>Section</div>
                                <div style={{ width: "15%" }}>Officer</div>
                                <div style={{ width: "15%" }}>Topic</div>
                                <div style={{ width: "25%" }}>Timestamp</div>
                                <div style={{ width: "15%" }}>Status</div>
                            </div>
                            {unAuditedCasecardList}
                            {auditedCasecardList.length > 0 && auditedCasecardList}
                        </div>
                    </Col>
                </div>
            )}
        </div>
    );
};

export default Dashboard;
