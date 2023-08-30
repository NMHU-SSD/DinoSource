import { useEffect, useState } from "react";
import { useLocation } from "react-router-dom";
import Tesseract from "tesseract.js";
import { Extract } from "../utils/algo";
import { saveToLocalStorage, getFromLocalStorage } from "../utils/storage";


const Processor = () => {
    const [imageSrc, setImageSrc] = useState("");
    const location = useLocation();
    const [, setText] = useState("");
    const [processing, setProcessing] = useState(false);
    const [dinosaurs, setDinosaurs] = useState({}); 
    const [counter, setCounter] = useState(0)
    const [comment, setComment] = useState("");

    let arr = [];
    let id = 0;
    
    useEffect(() => {
        if (location.state.imageSrc) {
            setImageSrc(location.state.imageSrc);
            // console.log(location.state.imageSrc)
        }
    }, [])



    const generateText = async (image, callback) => {
        setProcessing(true)
        await Tesseract.recognize(
            image,
            'eng',
            // { logger: m => console.log(m) }
        ).then(({ data: { text } }) => {
            setText(text.toLocaleLowerCase());
            setProcessing(false);
            const dino = callback(text.toLocaleLowerCase())
            setDinosaurs(dino);
        })

    };

    const handleComment = (e) => {
        const value = e.target.value;
        setComment(value);
        setCounter(value.length);
    }


    const onSave = () => {
        const existingData = getFromLocalStorage("info");

        if (existingData) {
            arr = existingData
        };


        const data = {
            name: dinosaurs.name,
            period: dinosaurs.period,
            caught: dinosaurs.caught,
            comment,
        };

        arr.push(data);
        saveToLocalStorage("info", arr);

        alert("data saved successfully");
    }

    return (
        <div className="d-flex h-100 flex-column align-center g-10 p-normal">
            {imageSrc && <img width={900} height={400} src={imageSrc} alt="image" />}
            <button className="button-main" onClick={() => generateText(imageSrc, Extract)}>{ processing ? "Please wait.." : "Extract Text" }</button>
            <div className="dinosaurs-info">
                <h1>Dinosaurs Information</h1>
               <span className="info">Name: {dinosaurs.name ?? "---"}</span><br/> 
               <span>period: {dinosaurs.period ?? "---"}</span><br/>
               {/* <span>caught: {dinosaurs.caught === false ? "false" : "true"}</span> */}
            </div>
            
             
            <label htmlFor="my-textarea">Add your comment:</label>
            <div className="textarea-container">
                <textarea id="my-textarea" onChange={value => handleComment(value)}  name="message" rows="5" maxLength="500"></textarea>
                <div className="counter">{counter} / 500 characters</div>
            </div>

            <button className="button-main save" onClick={() => onSave()}>Save</button>
        </div>
    )
};

export default Processor;