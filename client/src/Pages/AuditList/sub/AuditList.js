import React from 'react'

import { Row, Button, Alert, Col } from 'react-bootstrap'
import Form from 'react-bootstrap/Form'
import { useNavigate } from 'react-router-dom'

import './AuditList.css'

export default function AuditList() {
  return (
    <div className='dashboard_container'>
        <h2 style={{marginBottom: '20px'}}>Audited Cases</h2>
        <div className='dash-col-wrap'>
                <div className='dash-card-four'>
                    <div className='dash-text-one'>Recent Audits</div>
                    <div className='dash-case-warp'>
                        <div> Lim jun Jim</div>
                        <div>6:55pm,  15 Jun 2024</div>
                        <div>99%</div>
                        <div style={{ backgroundColor: "rgba(255, 0, 0, 0.4)", padding: "3px", borderRadius: '5px'}}>Pending</div>
                    </div>
                    <div className='dash-case-warp'>
                        <div> Lim jun Jim</div>
                        <div>6:55pm,  15 Jun 2024</div>
                        <div>99%</div>
                        <div style={{ backgroundColor: "rgba(0, 255, 0, 0.4)", padding: "3px", borderRadius: '5px'}}>Completed</div>
                    </div>
                    <div className='dash-case-warp'>
                        <div> Lim jun Jim</div>
                        <div>6:55pm,  15 Jun 2024</div>
                        <div>99%</div>
                        <div style={{ backgroundColor: "rgba(0, 255, 0, 0.4)", padding: "3px", borderRadius: '5px'}}>Completed</div>
                    </div>
                    <div className='dash-case-warp'>
                        <div> Lim jun Jim</div>
                        <div>6:55pm,  15 Jun 2024</div>
                        <div>99%</div>
                        <div style={{ backgroundColor: "rgba(0, 255, 0, 0.4)", padding: "3px", borderRadius: '5px'}}>Completed</div>
                    </div>
                    <div className='dash-case-warp'>
                        <div> Lim jun Jim</div>
                        <div>6:55pm,  15 Jun 2024</div>
                        <div>99%</div>
                        <div style={{ backgroundColor: "rgba(0, 255, 0, 0.4)", padding: "3px", borderRadius: '5px'}}>Completed</div>
                    </div>
                    <div className='dash-case-warp'>
                        <div> Lim jun Jim</div>
                        <div>6:55pm,  15 Jun 2024</div>
                        <div>99%</div>
                        <div style={{ backgroundColor: "rgba(0, 255, 0, 0.4)", padding: "3px", borderRadius: '5px'}}>Completed</div>
                    </div>
                </div>
        </div>
    </div>
  )
}
