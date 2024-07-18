//Libraries
import React, { Component, Fragment, lazy, Suspense } from 'react'
import { Route, Routes } from "react-router-dom";

//Component
import Login from './Pages/Login/sub/Login';

//CSS
import './App.css';

//page

const IndexNotFound = lazy( () => import ("./Pages/404"))
const Dashboard = lazy(()=> import("./Pages/Dashboard"));
const AuditList = lazy(()=> import("./Pages/AuditList"));
const AuditedCaseReview = lazy(()=> import("./Pages/AuditedCaseReview"));

class App extends Component {

  render(){ 
    return (
      <Routes>
        <Route exact path="/login" element={<Login/>}/>
        <Route exact path="/" element={<Login/>}/>
        <Route path="*" element={<DefaultContainer/>}/>
      </Routes>
    );
      }
}

const DefaultContainer = () => (
  <Fragment>
      <Suspense
        fallback={
          <div className="loader-container">
            <div className="loader-container-inner">
              <h6 className="mt-3">
                <i className="fas fa-spinner fa-spin"></i> Please wait while we
                are loading the page
              </h6>
            </div>
          </div>
        }>
          <Routes>
            <Route strict path="/dashboard/*" element={<Dashboard/>} />
            <Route strict path="/auditList/*" element={<AuditList/>} />
            <Route strict path="/auditedcasereview/*" element={<AuditedCaseReview/>} />
            <Route strich path="/*" element={<IndexNotFound/>} />
          </Routes>
      </Suspense>
  </Fragment>
)



export default App;
