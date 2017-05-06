"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function splice_(arr, index, howmany) {
    if (index === void 0) { index = null; }
    if (howmany === void 0) { howmany = null; }
    var items = [];
    for (var _i = 3; _i < arguments.length; _i++) {
        items[_i - 3] = arguments[_i];
    }
    // default values
    if (index === null) {
        index = arr.length;
    }
    if (howmany === null) {
        howmany = arr.length - index;
    }
    // modified array
    var modifiedArray = [];
    // first
    for (var i = 0; i < index; i++) {
        modifiedArray[i] = arr[i];
    }
    // middle
    for (var i = 0; i < items.length; i++) {
        modifiedArray[index + i] = items[i];
    }
    // last
    for (var i = index + items.length, j = index + howmany; j < arr.length; i++, j++) {
        modifiedArray[i] = arr[j];
    }
    // removed array
    var removedArray = [];
    for (var i = 0; i < howmany; i++) {
        removedArray[i] = arr[index + i];
    }
    // modify the original array
    // - clear
    arr.length = 0;
    // - deep copy
    for (var i = 0; i < modifiedArray.length; i++) {
        arr[i] = modifiedArray[i];
    }
    return removedArray;
}
exports.default = splice_;
//# sourceMappingURL=splice_.js.map