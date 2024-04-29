// Tutorial.js

import React from 'react';

function Tutorial() {
  return (
    <div>
      <h2>Rowhammer Vulnerability Tutorial</h2>
      <p>The Rowhammer vulnerability involves a specific issue with modern DRAM chips where repeatedly accessing a row of memory can cause bit flips in adjacent rows, potentially leading to security breaches.</p>
      <ol>
        <li>Understanding DRAM architecture: DRAM is organized into rows and columns, and data is accessed row-wise.</li>
        <li>What happens during a Rowhammer attack: Repeatedly accessing one row can unintentionally alter the data stored in nearby rows, compromising data integrity.</li>
        <li>Protecting against Rowhammer: Various techniques such as increased refresh rates and memory isolation strategies can mitigate the risk.</li>
      </ol>
    </div>
  );
}

export default Tutorial;
