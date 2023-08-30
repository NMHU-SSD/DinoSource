export const saveToLocalStorage = (text, data) => {
    return localStorage.setItem(text, JSON.stringify(data));
}

export const getFromLocalStorage = (text) => {
    return JSON.parse(localStorage.getItem(text));
}