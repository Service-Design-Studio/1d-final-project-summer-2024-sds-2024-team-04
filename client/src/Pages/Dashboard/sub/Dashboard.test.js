import { render, screen, waitFor } from '@testing-library/react';
import ErrorBoundary from './ErrorBoundary';
import Dashboard from './Dashboard';

// Mock fetch for success case
const mockFetchSuccess = () => {
  global.fetch = jest.fn(() =>
    Promise.resolve({
      json: () =>
        Promise.resolve({
          totalCases: 2,
          totalAuditedCases: 1,
          averageScore: 50.0
        })
    })
  );
};

// Mock fetch for failure case
const mockFetchFailure = () => {
  global.fetch = jest.fn(() =>
    Promise.reject(new Error('Fetch failed'))
  );
};

describe('Dashboard Component', () => {
  afterEach(() => {
    jest.resetAllMocks();
  });

  test('displays error message on fetch failure', async () => {
    mockFetchFailure();

    render(
      <ErrorBoundary>
        <Dashboard />
      </ErrorBoundary>
    );

    // Check if error message is displayed
    await waitFor(() => {
      expect(screen.getByText(/Something went wrong/i)).toBeInTheDocument();
    });
  });

//   test('displays data correctly when fetch is successful', async () => {
//     mockFetchSuccess();

//     render(
//       <ErrorBoundary>
//         <Dashboard />
//       </ErrorBoundary>
//     );

//     // Check if loading message is displayed initially
//     expect(screen.queryByTestId('loading')).toBeInTheDocument();

//     // Wait for data to be loaded and displayed
//     await waitFor(() => {
//       // Check that elements are in the document after loading
//       const totalCasesElement = screen.queryByTestId('total-cases');
//       const totalAuditedCasesElement = screen.queryByTestId('total-audited-cases');
//       const averageScoreElement = screen.queryByTestId('average-score');

//     //   expect(totalCasesElement).toBeInTheDocument();
//     //   expect(totalAuditedCasesElement).toBeInTheDocument();
//     //   expect(averageScoreElement).toBeInTheDocument();

//       // Assert their text content
//       expect(totalCasesElement).toHaveTextContent('2');
//       expect(totalAuditedCasesElement).toHaveTextContent('1');
//       expect(averageScoreElement).toHaveTextContent('50.0%');
//     });
//   });
});
