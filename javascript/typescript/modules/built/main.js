var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var TwoDPoint = (function () {
    function TwoDPoint(x, y) {
        this.x = x;
        this.y = y;
    }
    TwoDPoint.prototype.toString = function () {
        return this.x + ", " + this.y;
    };
    return TwoDPoint;
}());
/// <reference path="twodpoint.ts" />
var ThreeDPoint = (function (_super) {
    __extends(ThreeDPoint, _super);
    function ThreeDPoint(x, y, z) {
        var _this = _super.call(this, x, y) || this;
        _this.z = z;
        return _this;
    }
    ThreeDPoint.prototype.toString = function () {
        return _super.prototype.toString.call(this) + ", " + this.z;
    };
    return ThreeDPoint;
}(TwoDPoint));
/// <reference path="threedpoint.ts" />
var p = new ThreeDPoint(1, 2, 3);
alert(p.toString());
