export default function splice_(
    arr: any[], 
    index: number = 0, 
    howmany: number = 0, 
    ...items: any[]): any[] {
        // modified array
        let modifiedArray = [];
        // first
        for (let i = 0; i < index; i++) {
            modifiedArray[i] = arr[i];
        }
        // middle
        for (let i = 0; i < items.length; i++) {
            modifiedArray[index + i] = items[i];
        }
        // last
        for (let i = index + howmany; i < arr.length; i++) {
            modifiedArray[index + items.length + i] = arr[i];
        }

        arr = modifiedArray;

        // removed array
        let removedArray = [];
        for (let i = 0; i < howmany; i++) {
            removedArray[i] = arr[index + i];
        }
        return removedArray;
}