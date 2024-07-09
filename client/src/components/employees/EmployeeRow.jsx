import React from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

function EmployeeRow({ employee, onDelete }) {

  const handleDelete = async () => {
    const confirmDelete = window.confirm('Are you sure you want to delete this employee?');

    if (confirmDelete) {
      try {
        await axios.delete(`http://localhost:3000/api/v1/employees/${employee.id}`);
        onDelete(employee.id);
      } catch (error) {
        console.error('Error deleting employee:', error);
      }
    } else {
      return;
    }
  };

  return (
    <tr key={employee.id}>
      <td>{employee.full_name}</td>
      <td>{employee.email}</td>
      <td>{employee.contact_number}</td>
      <td>
        <Link to={`/employee/${employee.id}`} className="btn btn-primary">
          View
        </Link>
        <Link to={`/employee/${employee.id}/edit`} className="btn btn-warning ms-1">
          Edit
        </Link>
        <button onClick={handleDelete} className="btn btn-danger ms-1">Delete</button>
      </td>
    </tr>
  );
}

export default EmployeeRow;
