import React from "react";
import { useNavigate } from "react-router-dom";

const Nav = () => {
  const navigate = useNavigate();


    return (
        <nav className="nav d-flex justify-between align-center">
          <span className="logo">
            Dino<span className="dino-orange">Source</span>
          </span>
          <div className="d-flex g-10">
           <span onClick={() => navigate("/")} className="nav-link">Home</span>
           <span onClick={() => navigate("/history")} className="nav-link">History</span>
          </div>
        </nav>
    );
};

export default Nav;