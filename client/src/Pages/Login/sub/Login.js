//Libraries
import React, {useState, useEffect} from 'react'

//Component
import { Row, Button, Alert } from 'react-bootstrap'
import Form from 'react-bootstrap/Form'
import { useNavigate } from 'react-router-dom'

//CSS
import './Login.css'

import logo from '../../../assets/logo.svg.png'

const Login = () => {

    const [username, setUsername] = useState(String)
    const [password, setPassword] = useState(String);
    const alertMessage = "Wrong Username and Password. Try again !"
    const [show, setShow] = useState(false);
    const navigate = useNavigate();
    const defaultUserName = "myo@gmail.com"
    const defaultPw = "012345"


    const login = () => {
        if(password === defaultPw && username == defaultUserName){
            navigate("/dashboard")
        }
        else{
            setShow(true)
        }
    }
    

  return (
    <div className='login_container'>
        <Row>
            <img className='logo' src={logo} alt="logo"/>
        </Row>
        <Row>
        <Form>
                <Form.Group className="mb-3" controlId="formGroupPassword">
                    <Form.Label>Please enter the username and password</Form.Label>
                    <Form.Control 
                        className='login-pw-box'
                        type="email"
                        placeholder="Username"
                        onChange={(e) => {setUsername(e.target.value);
                        }} />
                    <Form.Control 
                        className='login-pw-box'
                        type="password" 
                        placeholder="Password"
                        onChange={(e) => {setPassword(e.target.value);
                        }} />
                </Form.Group>
                <Button className='login-btn' onClick={() => login()}>
                    Login
                </Button>
            </Form>
        </Row>

        <Alert show={show} variant="danger" style={{ marginTop: 10}} onClose={() => setShow(false)} dismissible>
            {alertMessage}
        </Alert>
    
    </div>
  )
}
export default Login;
