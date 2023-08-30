import './App.css';
import { Routes, Route } from 'react-router-dom';
import Home from "./pages/Home";
import Camera from './pages/Camera';
import Nav from './components/nav';
import Processor from './pages/Processor';
import History from './pages/History';
import Details from './pages/Details';

function App() {
  return (
    <>
      <Nav />
      <Routes>
          <Route path="/" element={ <Home /> } />
          <Route path="/camera" element={ <Camera /> } />
          <Route path="/processor" element={ <Processor /> } />
          <Route path="/history" element={<History />} />
          <Route path='/details' element={<Details />} />
      </Routes>
    </>
  );
}

export default App;
