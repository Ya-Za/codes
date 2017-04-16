var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
var A = (function () {
    function A(a) {
        this.a = a;
    }
    A.prototype.sayA = function () {
        console.log(this.a);
    };

    A.sayAA = function () {
        console.log('aa');
    };
    A.aa = 'aa';
    return A;
})();

var B = (function (_super) {
    __extends(B, _super);
    function B(a, b) {
        _super.call(this, a);
        this.b = b;
    }
    B.prototype.sayB = function () {
        console.log(this.b);
    };

    B.sayBB = function () {
        console.log('bb');
    };
    B.bb = 'bb';
    return B;
})(A);

var a = new A('a');

var b = new B('a', 'b');
b.sayA();
b.sayAA();
b.sayB();
b.sayBB();
