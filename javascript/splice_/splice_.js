"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function splice_(arr, index, howmany) {
    if (index === void 0) { index = 0; }
    if (howmany === void 0) { howmany = 0; }
    var items = [];
    for (var _i = 3; _i < arguments.length; _i++) {
        items[_i - 3] = arguments[_i];
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
    for (var i = index + howmany; i < arr.length; i++) {
        modifiedArray[index + items.length + i] = arr[i];
    }
    arr = modifiedArray;
    // removed array
    var removedArray = [];
    for (var i = 0; i < howmany; i++) {
        removedArray[i] = arr[index + i];
    }
    return removedArray;
}
exports.default = splice_;
//# sourceMappingURL=splice_.js.map