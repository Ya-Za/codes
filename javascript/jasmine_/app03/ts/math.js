"use strict";
exports.__esModule = true;
function add(a, b) {
    return a + b;
}
exports.add = add;
function mul(a, b) {
    return a * b;
}
exports.mul = mul;
function neg(a) {
    return mul(-1, a);
}
exports.neg = neg;
function sub(a, b) {
    return add(a, neg(b));
}
exports.sub = sub;
function inv(a) {
    return 1 / a;
}
exports.inv = inv;
function div(a, b) {
    return mul(a, inv(b));
}
exports.div = div;
