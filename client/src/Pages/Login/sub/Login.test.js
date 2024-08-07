// Import libraries
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import '@testing-library/jest-dom'; // For extended matchers
import Login from './Login'; // Adjust the path according to your project structure
import { MemoryRouter, useNavigate } from 'react-router-dom';

// Mock the useNavigate hook
jest.mock('react-router-dom', () => ({
    ...jest.requireActual('react-router-dom'),
    useNavigate: jest.fn()
}));

describe('Login Component', () => {
    test('renders login form with username and password fields', () => {
        render(
            <MemoryRouter>
                <Login />
            </MemoryRouter>
        );
        expect(screen.getByPlaceholderText('Username')).toBeInTheDocument();
        expect(screen.getByPlaceholderText('Password')).toBeInTheDocument();
        expect(screen.getByText('Login')).toBeInTheDocument();
    });

    test('shows error message for incorrect credentials', () => {
        render(
            <MemoryRouter>
                <Login />
            </MemoryRouter>
        );
        
        fireEvent.change(screen.getByPlaceholderText('Username'), { target: { value: 'wrong@gmail.com' } });
        fireEvent.change(screen.getByPlaceholderText('Password'), { target: { value: 'wrongpw' } });
        fireEvent.click(screen.getByText('Login'));
        
        expect(screen.getByText('Wrong Username and Password. Try again !')).toBeInTheDocument();
    });

    test('redirects to dashboard on correct credentials', () => {
        // Create a mock implementation of useNavigate
        const navigate = jest.fn();
        useNavigate.mockReturnValue(navigate);

        render(
            <MemoryRouter>
                <Login />
            </MemoryRouter>
        );

        fireEvent.change(screen.getByPlaceholderText('Username'), { target: { value: 'myo@gmail.com' } });
        fireEvent.change(screen.getByPlaceholderText('Password'), { target: { value: '012345' } });
        fireEvent.click(screen.getByText('Login'));

        expect(navigate).toHaveBeenCalledWith('/dashboard');
    });

    test('handles empty username and password fields', () => {
        render(
            <MemoryRouter>
                <Login />
            </MemoryRouter>
        );
        
        fireEvent.click(screen.getByText('Login'));
        
        expect(screen.getByText('Wrong Username and Password. Try again !')).toBeInTheDocument();
    });

    test('handles various invalid username and password inputs', () => {
        const invalidInputs = [
            { username: 'invalid', password: '012345' },
            { username: 'myo@gmail.com', password: 'wrongpw' },
            { username: '', password: '012345' },
            { username: 'myo@gmail.com', password: '' },
            { username: 'myo@gmail.com', password: '01234' }
        ];

        render(
            <MemoryRouter>
                <Login />
            </MemoryRouter>
        );

        invalidInputs.forEach(({ username, password }) => {
            fireEvent.change(screen.getByPlaceholderText('Username'), { target: { value: username } });
            fireEvent.change(screen.getByPlaceholderText('Password'), { target: { value: password } });
            fireEvent.click(screen.getByText('Login'));
            
            expect(screen.getByText('Wrong Username and Password. Try again !')).toBeInTheDocument();
        });
    });
});
