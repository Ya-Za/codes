"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const math = require("mathjs");
let forces = [
    [1, 2],
    [3, 4],
    [5, 6]
];
// let sumOfForces = [0, 0];
// for (let force of forces) {
//     sumOfForces = math.add(sumOfForces, force) as number[];
// }
let sumOfForces = forces.reduce((acc, cur) => math.add(acc, cur), [0, 0]);
console.log(sumOfForces);
console.log(math.dotMultiply([1, 2, 3], 2));
//# sourceMappingURL=main.js.map