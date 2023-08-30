import { useEffect, useState } from "react";
import Webcam from "react-webcam";
import { useNavigate } from "react-router-dom";

const Camera = () => {
    const [capture, setCapture] = useState(false);
    const navigate = useNavigate();
     
    
    useEffect(() => {
        handleFileUpload();
        return () => {
            setCapture(false);
        }
    }, [])

    const handleFileUpload = () => {
        const uploadFileField = document.getElementById("upload");
        uploadFileField.addEventListener(
          "change",
          function () {
            const fileReader = new FileReader();
            fileReader.onload = () => {
              const srcData = fileReader.result;
              navigate("/processor", { state: { imageSrc: srcData } });
            };
            fileReader.readAsDataURL(this.files[0]);
          },
          false
        );
    }

    const videoConstraints = {
      width: 1280,
      height: 720,
      facingMode: "user",
    };

    return (
      <div className="d-flex p-normal flex-column g-50 justiy-center align-center">
        <Webcam
          audio={false}
          height={420} //set height using windowWidth and windowHeight and make site responsive
          screenshotFormat="image/png"
          width={1280}
          videoConstraints={videoConstraints}
        >
          {({ getScreenshot }) => (
            <div className="d-flex g-10">
              <button
                className="button-main"
                onClick={() => {
                  setCapture(true);
                  setTimeout(() => {
                    const imageSrc = getScreenshot();
                    navigate("/processor", { state: { imageSrc } });
                  }, 1500);
                }}
              >
                {capture ? "Capturing..." : "Capture photo"}
              </button>
              <button className="button-main">
                <input
                  type="file"
                  id="upload"
                  accept="image/*"
                />
              </button>
            </div>
          )}
        </Webcam>
      </div>
    );
};

export default Camera;