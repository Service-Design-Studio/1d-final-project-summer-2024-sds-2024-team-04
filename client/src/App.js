import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import EmployeeList from './components/employees/EmployeeList';
import EmployeeDetails from './components/employees/EmployeeDetails';
import EmployeeNewForm from './components/employees/EmployeeNewForm';
import EmployeeEditForm from './components/employees/EmployeeEditForm';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element=<EmployeeList/> />
        <Route path="/employee/:id" element=<EmployeeDetails/> />
        <Route path="/employee/new" element=<EmployeeNewForm/> />
        <Route path="/employee/:id/edit" element=<EmployeeEditForm/> />
      </Routes>
    </Router>
  );
}

export default App;
