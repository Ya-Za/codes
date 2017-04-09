"use strict";

function _possibleConstructorReturn(self, call) {
    if (!self) {
        throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
    }
    return call && (typeof call === "object" || typeof call === "function") ? call : self;
}

function _inherits(subClass, superClass) {
    if (typeof superClass !== "function" && superClass !== null) {
        throw new TypeError("Super expression must either be null or a function, not " + typeof superClass);
    }
    subClass.prototype = Object.create(
        superClass && superClass.prototype,
        {
            constructor: {
                value: subClass,
                enumerable: false,
                writable: true,
                configurable: true
            }
        }
    );
    if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass;
}

function _classCallCheck(instance, Constructor) {
    if (!(instance instanceof Constructor)) {
        throw new TypeError("Cannot call a class as a function");
    }
}

var A = function A(a) {
    _classCallCheck(this, A);

    this.a = a;
};

var B = function (_A) {
    _inherits(B, _A);

    function B(a, b) {
        _classCallCheck(this, B);

        var _this = _possibleConstructorReturn(this, (B.__proto__ || Object.getPrototypeOf(B)).call(this, a));

        _this.b = b;
        return _this;
    }

    return B;
}(A);

var C = function (_B) {
    _inherits(C, _B);

    function C(a, b, c) {
        _classCallCheck(this, C);

        var _this2 = _possibleConstructorReturn(this, (C.__proto__ || Object.getPrototypeOf(C)).call(this, a, b));

        _this2.c = c;
        return _this2;
    }

    return C;
}(B);