// Home.js

// Home.js

import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Home = () => {
  const [data, setData] = useState('');
  const [testResults, setTestResults] = useState('');
  const [loading, setLoading] = useState(false);

  const runRowhammerTest = async () => {
    setLoading(true);
    // Simulated delay to mimic test execution
    setTimeout(() => {
      const pass = Math.random() < 0.5;
      const resultMessage = pass ? 'Rowhammer test passed!' : 'Rowhammer test failed!';
      const resultColor = pass ? 'green' : 'red';
      setTestResults({ message: resultMessage, color: resultColor });
      setLoading(false);
    }, 2000);
  };

  useEffect(() => {
    axios.get('/api/data')
      .then(response => {
        setData(response.data.message);
      })
      .catch(error => {
        console.error('Error fetching data:', error);
      });
  }, []);

  return (
    <div>
      <h1>Welcome to RowHammer Analysis</h1>
      <p>{data}</p>
      <p>Click the button below to run the Rowhammer vulnerability test on your system. This test will attempt to induce the Rowhammer effect to check for vulnerabilities in your DRAM.</p>
      <div>
        <button onClick={runRowhammerTest} disabled={loading}>
          {loading ? 'Running Test...' : 'Run Rowhammer Test'}
        </button>
        <div style={{ color: testResults.color }}>{testResults.message}</div>
      </div>
    </div>
  );
};

export default Home;
