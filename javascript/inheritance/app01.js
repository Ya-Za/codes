var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = (__.prototype = b.prototype, new __());
};
var A = (function () {
    function A(a) {
        this.a = a;
    }
    return A;
}());
var B = (function (_super) {
    function B(a, b) {
        _super.call(this, a)
        this.b = b;
    }
    __extends(B, _super);
    return B;
}(A));
var C = (function (_super) {
    __extends(C, _super);
    function C(a, b, c) {
        _super.call(this, a, b)
        this.c = c;
    }
    return C;
}(B));

var c = new C('a', 'b', 'c')
console.log(c)