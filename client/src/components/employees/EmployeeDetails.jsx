import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';
import { Link } from 'react-router-dom';

function EmployeeDetails() {
  const { id } = useParams(); // Accessing the id parameter from the URL
  const [employee, setEmployee] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchEmployee = async () => {
      try {
        const response = await axios.get(`http://localhost:3000/api/v1/employees/${id}`);
        setEmployee(response.data); // Set the fetched employee data
        setLoading(false);
      } catch (error) {
        console.error('Error fetching employee details:', error);
        setLoading(false);
      }
    };

    fetchEmployee();
  }, [id]); // Dependency array ensures the effect runs when id changes

  if (loading) {
    return <div>Loading...</div>;
  }

  if (!employee) {
    return <div>Employee not found</div>;
  }

  return (
    <div className="container">
      <div className="row">
        <div className="col-lg-8 mx-auto">
          <div className="card">
            <div className="card-body">
              <h5 className="card-title">Employee Details</h5>
              <div className="card-text">
                <p><strong>Name:</strong> {employee.full_name}</p>
                <p><strong>Email:</strong> {employee.email}</p>
                <p><strong>Contact Number:</strong> {employee.contact_number}</p>
                <p><strong>Date of Hiring:</strong> {employee.date_of_hiring}</p>
                <p><strong>Role:</strong> {employee.role}</p>
              </div>
              <Link to={`/`} className="btn btn-primary">
                Employee List
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default EmployeeDetails;
