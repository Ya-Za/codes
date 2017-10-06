export function forEach(obj: any, cb: any): any {
    for (let key in obj) {
        cb(obj[key], key, obj);
    }
} 

export function map(obj: any, cb: any): any {
    for (let key in obj) {
        obj[key] = cb(obj[key], key, obj);
    }
} 
