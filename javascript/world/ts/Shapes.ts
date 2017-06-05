import { R2 } from "./Common";

// Abstract Shape
export abstract class Shape {
    faceColor: string
    edgeColor: string

    constructor(
        public ctx: CanvasRenderingContext2D,
        public rx: number,
        public ry: number
    ) {
        this.faceColor = "white";
        this.edgeColor = "black";
    }

    /**
     * Draw shape
     * @param c Center
     */
    abstract draw(c: R2): void
}

// Circle
export class Circle extends Shape {
    constructor(
        ctx: CanvasRenderingContext2D,
        public radius: number) {
        super(ctx, radius, radius);
    }

    draw(c: R2) {
        // circle
        this.ctx.beginPath();
        this.ctx.arc(c[0], c[1], this.radius, 0, 2 * Math.PI);
        this.ctx.closePath();
        // fill
        this.ctx.fillStyle = this.faceColor;
        this.ctx.fill();
        // stroke
        this.ctx.strokeStyle = this.edgeColor;
        this.ctx.stroke();
    }
}

// Rectangle
export class Rectangle extends Shape {
    constructor(
        ctx: CanvasRenderingContext2D,
        public width: number,
        public height: number) {
        super(ctx, width / 2, height / 2);
    }

    draw(c: R2) {
        let x = c[0] - (this.width / 2);
        let y = c[1] - (this.height / 2)

        this.ctx.fillRect(x, y, this.width, this.height);
        this.ctx.strokeRect(x, y, this.width, this.height);
    }
}

// Square
export class Square extends Rectangle {
    constructor(
        ctx: CanvasRenderingContext2D,
        public width: number) {
        super(ctx, width, width);
    }
}