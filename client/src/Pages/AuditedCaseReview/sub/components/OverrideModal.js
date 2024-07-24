import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import Form from 'react-bootstrap/Form';
import { useState } from 'react';


import './styles/OverrideModal.css'

export default function OverrideModal(props) {

    const [editScore, setEditScore] = useState(props.aiScore)

  return (
    <Modal
      {...props}
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
                            var tempScore = editScore
                            tempScore.aiScore1 = true
                            setEditScore(tempScore)
                        }}
                    /> Satisfy
                </div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={!editScore.aiScore1}
                        onChange={() => {
                            var tempScore = editScore
                            tempScore.aiScore1 = false
                            setEditScore(tempScore)
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
                        onChange={() => console.log("Something")}
                    /> Satisfy
                </div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={!editScore.aiScore2}
                        onChange={() => console.log("Something")}
                    /> Unsatisfy
                </div>
            </div>
            <div className='radio-wrap'>
                <div style={{width: '15%'}}>Cirteria3</div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={editScore.aiScore3}
                        onChange={() => console.log("Something")}
                    /> Satisfy
                </div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={!editScore.aiScore3}
                        onChange={() => console.log("Something")}
                    /> Unsatisfy
                </div>
            </div>
            <div className='radio-wrap'>
                <div style={{width: '15%'}}>Cirteria4</div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={editScore.aiScore4}
                        onChange={() => console.log("Something")}
                    /> Satisfy
                </div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={!editScore.aiScore4}
                        onChange={() => console.log("Something")}
                    /> Unsatisfy
                </div>
            </div>
            <div className='radio-wrap'>
                <div style={{width: '15%'}}>Cirteria5</div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={editScore.aiScore5}
                        onChange={() => console.log("Something")}
                    /> Satisfy
                </div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={!editScore.aiScore5}
                        onChange={() => console.log("Something")}
                    /> Unsatisfy
                </div>
            </div>
            <div className='radio-wrap'>
                <div style={{width: '15%'}}>Cirteria6</div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={editScore.aiScore6}
                        onChange={() => console.log("Something")}
                    /> Satisfy
                </div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={!editScore.aiScore6}
                        onChange={() => console.log("Something")}
                    /> Unsatisfy
                </div>
            </div>
            <div className='radio-wrap'>
                <div style={{width: '15%'}}>Cirteria7</div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={editScore.aiScore7}
                        onChange={() => console.log("Something")}
                    /> Satisfy
                </div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={!editScore.aiScore7}
                        onChange={() => console.log("Something")}
                    /> Unsatisfy
                </div>
            </div>
            <div className='radio-wrap'>
                <div style={{width: '15%'}}>Cirteria8</div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={editScore.aiScore8}
                        onChange={() => console.log("Something")}
                    /> Satisfy
                </div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={!editScore.aiScore8}
                        onChange={() => console.log("Something")}
                    /> Unsatisfy
                </div>
            </div>
            <div className='radio-wrap'>
                <div style={{width: '15%'}}>Cirteria9</div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={editScore.aiScore9}
                        onChange={() => console.log("Something")}
                    /> Satisfy
                </div>
                <div style={{width: '15%'}}>
                    <input
                        type="radio"
                        checked={!editScore.aiScore9}
                        onChange={() => console.log("Something")}
                    /> Unsatisfy
                </div>
            </div>
            <div className='radio-wrap'>
                <div style={{width: '15%'}}>Total:</div>
                <Form.Control type="number" style={{width: '30%'}} value={editScore.totalScore} />
            </div>
            <div className='comment-wrap'>
                <div style={{width: '15%'}}>Comment:</div>
                <Form.Control as="textarea" rows={3} style={{width: '100%'}} value={`Some comments are here!`}/>
            </div>
        </div>
        }
        
      </Modal.Body>
      <Modal.Footer>
        <Button onClick={props.onHide}>Submit</Button>
        <Button onClick={props.onHide}>Close</Button>
      </Modal.Footer>
    </Modal>
  );
}
