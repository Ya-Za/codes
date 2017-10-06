export class MyCanvas {
    context: CanvasRenderingContext2D;
    width: number;
    height: number;

    constructor(canvas: HTMLCanvasElement) {
        this.context = canvas.getContext("2d") as CanvasRenderingContext2D;
        this.width = canvas.width;
        this.height = canvas.height;
    }

    clear(color: string = "white") {
        this.context.fillStyle = color;
        this.context.fillRect(0, 0, this.width, this.height);
    }

    // todo
    // - draw this [figure](https://www.w3schools.com/graphics/canvas_intro.asp)

    segment(x0: number, y0: number, x1: number, y1: number) {
        this.context.moveTo(x0, y0);
        this.context.lineTo(x1, y1);

        this.context.stroke();
    }
    circle(cx: number, cy: number, r: number) {
        this.context.beginPath();
        this.context.arc(cx, cy, r, 0, 2 * Math.PI, true);
    }
    // Gradient
    gradient1() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;

        // gradient
        const g = c.createLinearGradient(w / 3, 0, 2 * w / 3, h);
        g.addColorStop(0, 'red');
        g.addColorStop(1, 'blue');

        c.fillStyle = g;
        c.fillRect(0, 0, w, h);

        // delimiter lines
        const lineWidth = w / 100;
        const lineColor = 'black'
        // - defines
        //  - first line
        const l1 = {
            x0: w / 3,
            y0: 0,
            x1: w / 3,
            y1: h
        }
        //  - second line
        const l2 = {
            x0: 2 * w / 3,
            y0: 0,
            x1: 2 * w / 3,
            y1: h
        }
        // - draw
        //  - firs line
        c.moveTo(l1.x0, l1.y0);
        c.lineTo(l1.x1, l1.y1);
        //  - second line
        c.moveTo(l2.x0, l2.y0);
        c.lineTo(l2.x1, l2.y1);

        c.lineWidth = lineWidth;
        c.strokeStyle = lineColor;
        c.stroke();
    }
    gradient2() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;

        // delimiter lines
        const lineWidth = w / 100;
        const lineColor = 'black'
        // - defines
        //  - first circle
        const c1 = {
            x: w / 2 + 50,
            y: h / 2,
            r: h / 5
        }
        //  - second circle
        const c2 = {
            x: w / 2,
            y: h / 2,
            r: 2 * h / 5
        }

        // gradient
        const g = c.createRadialGradient(c1.x, c1.y, c1.r, c2.x, c2.y, c2.r);
        g.addColorStop(0, 'red');
        g.addColorStop(0.5, 'green');
        g.addColorStop(1, 'blue');

        c.fillStyle = g;
        c.fillRect(0, 0, w, h);


        // draw
        c.lineWidth = lineWidth;
        c.strokeStyle = lineColor;
        // - firs circle
        this.circle(c1.x, c1.y, c1.r);
        // - second circle
        this.circle(c2.x, c2.y, c2.r);
    }
    // Text
    text1() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;

        // properties
        // - text
        const x = w / 2;
        const y = h / 2;
        const text = 'Hello, World!';
        // delimiter lines
        const lineWidth = w / 1000;
        const lineColor = 'red'

        // draw
        // - text
        c.font = '30px Arial';
        c.fillStyle = 'black';
        c.fillText(text, x, y);
        // - lines
        c.lineWidth = lineWidth;
        c.strokeStyle = lineColor;
        //  - horizontal
        const hl = {
            x0: x,
            y0: 0,
            x1: x,
            y1: h
        }
        this.segment(hl.x0, hl.y0, hl.x1, hl.y1);
        //  - vertical
        const vl = {
            x0: 0,
            y0: y,
            x1: w,
            y1: y
        }
        this.segment(vl.x0, vl.y0, vl.x1, vl.y1);
    }
    // Shadows
    shadow1() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;

        const b = 100;
        c.shadowBlur = b;
        c.shadowColor = 'black';
        c.shadowOffsetX = 2 * b;

        c.fillStyle = 'red';
        const l = 4 * b;
        const l_2 = l / 2;
        c.fillRect(
            (w - l) / 2,
            (h - l) / 2,
            l,
            l
        )

        // blue rectangle
        c.fillStyle = 'blue';
        c.fillRect(
            (w + l - b) / 2,
            (h - l - b) / 2,
            b,
            b
        )
    }
    // Pattern
    pattern1() {

        this.context.fillStyle = this.context.createPattern(makeCanvas(), 'repeat');
        this.context.fillRect(0, 0, this.width, this.height);

        // Local function
        function makeCanvas(): HTMLCanvasElement {
            // properties
            // - canvas
            const w = 100;
            const h = 100;
            // - text
            const text = 'Hello, World';
            const font = '12px Arial';
            const color = 'black';
            const alignment = 'center';

            // canvas
            const canvas = document.createElement('canvas') as HTMLCanvasElement;
            canvas.width = w;
            canvas.height = h;
            const ctx = canvas.getContext('2d') as CanvasRenderingContext2D;
            // text
            ctx.font = font;
            ctx.textAlign = alignment;
            ctx.fillText(text, w / 2, h / 2)


            return canvas;
        }
    }
    pattern2() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;
        const s = 0.1;

        // c.scale(w, h);

        // background
        let img = createPatternImage(s * w, s * h, 'black');
        c.fillStyle = c.createPattern(img, 'repeat');
        c.fillRect(0, 0, w, h);

        // foreground
        img = createPatternImage(s * w, s * h, 'red');
        c.fillStyle = c.createPattern(img, 'repeat');
        c.strokeStyle = 'green';
        c.beginPath();
        c.rect(w / 4, h / 4, w / 2 , h / 2);
        c.fill();
        c.stroke();
        

        // Local functions
        function createPatternImage(width: number, height: number, color: string): HTMLCanvasElement {
            const canvas = document.createElement('canvas');
            canvas.width = width;
            canvas.height = height;

            const ctx = canvas.getContext('2d') as CanvasRenderingContext2D;
            ctx.scale(width, height);

            ctx.beginPath();
            ctx.moveTo(0, 1);
            ctx.lineTo(1, 1);
            ctx.lineTo(0.5, 0);
            ctx.closePath();

            ctx.fillStyle = color;
            ctx.fill();

            return canvas;
        }
    }
    // Line
    line1() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;

        // properties
        const l = 400;
        const x = (w - l) / 2;
        const y = (h - l) / 2;
        // black square
        c.lineWidth = 2;
        c.strokeStyle = 'black';
        c.strokeRect(x, y, l, l);
        // red square
        c.lineWidth = 1;
        c.strokeStyle = 'red';
        c.strokeRect(x, y, l, l);
    }
    // Path
    path1() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;

        c.moveTo(100, 100);
        c.lineTo(200, 100);
        c.lineTo(200, 200);
        c.closePath();

        c.moveTo(200, 200);
        c.lineTo(300, 200);
        c.lineTo(300, 300);
        c.closePath();

        // fill
        c.fillStyle = 'red';
        c.fill();

        // stroke
        c.lineWidth = 10;
        c.stroke();
    }
    path2() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;

        // properties
        // - outer square
        const ol = 400;
        // - inner squre
        const il = ol / 2;

        // outer square
        const os = {
            x: (w - ol) / 2,
            y: (h - ol) / 2,
            w: ol,
            h: ol
        }
        // - clockwise
        // c.moveTo(os.x, os.y);
        // c.lineTo(os.x + os.w, os.y);
        // c.lineTo(os.x + os.w, os.y + os.h);
        // c.lineTo(os.x, os.y + os.h);
        // c.closePath();
        c.rect(os.x, os.y, os.w, os.h);
        // inner square
        const is = {
            x: (w - il) / 2,
            y: (h - il) / 2,
            w: il,
            h: il
        }
        // - clockwise
        c.moveTo(is.x, is.y);
        c.lineTo(is.x + is.w, is.y);
        c.lineTo(is.x + is.w, is.y + is.h);
        c.lineTo(is.x, is.y + is.h);
        c.closePath();

        // fill
        c.fillStyle = 'red';
        c.fill('evenodd');

        // stroke
        c.lineWidth = 10;
        c.stroke();
    }
    // Transform
    transform1() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;
        const that = this;

        c.scale(2, 2);
        c.translate(100, 100);
        disk('red');

        c.setTransform(1, 0, 0, 1, 0, 0);

        c.translate(100, 100);
        c.scale(2, 2);
        disk('blue');

        // c.setTransform(2, 0, 0, 2, 100, 100);
        // disk('green');

        c.setTransform(1, 0, 0, 1, 0, 0);

        c.transform(1, 0, 0, 1, 100, 100);
        c.transform(2, 0, 0, 2, 0, 0);
        disk('green');

        // Local functions
        function disk(color: string) {
            that.circle(0, 0, 10);
            c.fillStyle = color;
            c.fill();
        }
    }
    // drawImage
    drawImage1() {
        // aliases
        const c = this.context;
        const w = this.width;
        const h = this.height;
        const s = 0.1;

        // c.scale(w, h);

        const img = createPatternImage(s * w, s * h);

        // c.drawImage(img, 0, 0);

        c.fillStyle = c.createPattern(img, 'repeat');
        c.beginPath();
        c.arc(0.5 * w, 0.5 * h, 0.5 * h, 0, 2 * Math.PI);
        c.fill();

        // Local functions
        function createPatternImage(width: number, height: number): HTMLCanvasElement {
            const canvas = document.createElement('canvas');
            canvas.width = width;
            canvas.height = height;

            const ctx = canvas.getContext('2d') as CanvasRenderingContext2D;
            ctx.scale(width, height);

            ctx.beginPath();
            ctx.moveTo(0, 1);
            ctx.lineTo(1, 1);
            ctx.lineTo(0.5, 0);
            ctx.closePath();

            ctx.fillStyle = 'black';
            ctx.fill();

            return canvas;
        }
    }
}