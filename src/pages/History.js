import { useEffect, useState } from "react";
import { getFromLocalStorage } from "../utils/storage";
import { useNavigate } from "react-router-dom";

const History = () => {
    const [dinosaurs, setDinosaurs] = useState(null);

    const navigate = useNavigate();

    useEffect(() => {
        const data = getFromLocalStorage("info");
        if (data) {
            setDinosaurs(data);
        }
    }, [])

    return (
        <div className="list-container">
        <div className="list">
          <div className="list-header">
          <div className="list-cell">View</div>
            <div className="list-cell">Name of Dinosaurs</div>
            <div className="list-cell">Geological period</div>
            {/* <div className="list-cell">Caught</div> */}
            <div className="list-cell">Comment</div>
          </div>
          {dinosaurs && dinosaurs.map((item, index) => (
            <div key={index} className="list-row">
              <div className="list-cell details" onClick={() => navigate("/details", {state: {name: item.name, period: item.period, caught: item.caught, comment: item.comment}})}>Details</div>
              <div className="list-cell">{item.name}</div>
              <div className="list-cell">{item.period}</div>
              {/* <div className="list-cell">{item.caught === true ? "Yes" : "No"}</div> */}
              <div className="list-cell">{item.comment}</div>
            </div>
          ))}
        </div>
        </div>
      );
};

export default History;