"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
main();
function main() {
    let n = numbers();
    for (let v of n) {
        console.log(v);
    }
}
function* one() {
    yield* two();
}
function* two() {
    yield 1;
}
function* numbers() {
    for (let i = 0; i < 10; i++) {
        yield i;
    }
}
//# sourceMappingURL=main.js.map