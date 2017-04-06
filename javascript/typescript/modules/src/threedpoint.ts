/// <reference path="twodpoint.ts" />
class ThreeDPoint extends TwoDPoint {
    z: number

    constructor(x: number, y: number, z: number) {
        super(x, y)
        this.z = z
    }

    toString() {
        return `${super.toString()}, ${this.z}`
    }
}