import React, { useState } from "react";
import { useLocation } from "react-router-dom";


// function Details(props) {
//   const { name, image, comment } = props;
//   const location = useLocation();
//   const data = location.state;


  
//   return (
//     <div className="details-page">
//       <img src={image} alt="" className="details-page__image" />
      
//     </div>
//   );
// }

// export default Details;



function ProfileDetails() {
    const [name, setName] = useState('John Smith');
    const [comment, setComment] = useState('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam volutpat sapien vel est feugiat interdum.');

      const location = useLocation();
      const data = location.state;
  
    return (
      <div className="profile-details">
        {/* <div className="profile-image">
          <img src="/path/to/image.jpg" alt="Profile Image" />
        </div> */}
        <div className="profile-info">
          <div className="profile-name">
           <label htmlFor="name">Dinosaurs Name</label>
            <input type="text" id="name" value={data.name} onChange={(e) => setName(e.target.value)} />
          </div>

          <div className="profile-name">
           <label htmlFor="peroid">Geological Period</label>
            <input type="text" id="period" value={data.period} onChange={(e) => setName(e.target.value)} />
          </div>

          {/* <div className="profile-name">
           <label htmlFor="caught">Caught</label>
            <input type="text" id="caught" value={data.caught} onChange={(e) => setName(e.target.value)} />
          </div> */}

          <div className="profile-comment">
            <label htmlFor="name">comment</label>
            <textarea value={data.comment} onChange={(e) => setComment(e.target.value)} />
          </div>
        </div>
      </div>
    );
  }
  
  export default ProfileDetails;