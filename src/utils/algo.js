import dinosaurs from "../dinosaurs.json";

export const Extract = (data) => {
    const text = data.split(" ");
    const dino = Object.keys(dinosaurs);
     
    const capturedDinosaurs = isAvailable(text, dino);

    return dinosaurs[capturedDinosaurs];
    
}

const isAvailable = (text, dinosaurs) => {

   for (let i = 0; i < dinosaurs.length; i++) {
    const found = text.includes(dinosaurs[i]);

    if (found) return dinosaurs[i]
   }
}




