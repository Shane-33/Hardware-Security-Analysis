// App.js
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import React from 'react';
import Home from './components/Home';
import TestPage from './components/TestPage';
import About from './components/About';
import Tutorial from './components/Tutorial';
import './App.css';

function App() {
  return (
    <Router>
      <div className="App">
        <Switch>
          <Route path="/" exact component={Home} />
          <Route path="/test" component={TestPage} />
          <Route path="/about" component={About} />
          <Route path="/tutorial" component={Tutorial} />
        </Switch>
      </div>
    </Router>
  );
}

export default App;
