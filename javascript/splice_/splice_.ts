export default function splice_(
    arr: any[],
    index: number = null,
    howmany: number = null,
    ...items: any[]): any[] {
    // default values
    if (index === null) {
        index = arr.length;
    }
    if (howmany === null) {
        howmany = arr.length - index;
    }
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
    for (let i = index + items.length, j = index + howmany;
        j < arr.length;
        i++ , j++) {
        modifiedArray[i] = arr[j];
    }

    // removed array
    let removedArray = [];
    for (let i = 0; i < howmany; i++) {
        removedArray[i] = arr[index + i];
    }

    // modify the original array
    // - clear
    arr.length = 0;
    // - deep copy
    for (let i = 0; i < modifiedArray.length; i++) {
        arr[i] = modifiedArray[i];
    }

    return removedArray;
}