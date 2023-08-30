import React from "react";
import { useNavigate } from "react-router-dom";

const Home = () => {
    const navigate = useNavigate();

    const handleClick = () => {
        navigate("/camera");
    }

    const handleListNavigate = () => {
        navigate("/history")
    }

    return (
        <div className="home-parent-div d-flex flex-column justify-center g-50 align-center">
            <div className="d-flex justify-center w-100">
                <img src="./dino.png" />
           </div>
            <div className="d-flex justify-center w-100 g-50">
                <button className="button-main" onClick={handleClick}>Capture</button>
                <button className="button-main" onClick={() => handleListNavigate()}>List View</button>
            </div>
        
        </div>
    )
};

export default Home;