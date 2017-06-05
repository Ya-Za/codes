define("Common", ["require", "exports"], function (require, exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
});
define("Physics", ["require", "exports", "mathjs"], function (require, exports, math) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    class Physics {
        constructor(dt) {
            this.location = [0, 0];
            this.mass = 1;
            this.velocity = [0, 0];
            this.forces = [[0, 0]];
            this.dt = dt;
            this.elasticity = 1;
        }
        updateDisplacement() {
            // previous time
            //  - sum of the forces
            let F = this.sumOfForces();
            //  - acceleration
            let a = math.dotMultiply(F, 1 / this.mass);
            // current time
            // - velocity
            this.velocity = math.add(this.velocity, math.dotMultiply(a, this.dt));
            // - displacement
            this.dx = math.dotMultiply(this.velocity, this.dt);
        }
        updateLocation() {
            this.location = math.add(this.location, this.dx);
        }
        sumOfForces() {
            return this.forces.reduce((acc, cur) => math.add(acc, cur), [0, 0]);
        }
    }
    exports.default = Physics;
});
define("Shapes", ["require", "exports"], function (require, exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    // Abstract Shape
    class Shape {
        constructor(ctx, rx, ry) {
            this.ctx = ctx;
            this.rx = rx;
            this.ry = ry;
            this.faceColor = "white";
            this.edgeColor = "black";
        }
    }
    exports.Shape = Shape;
    // Circle
    class Circle extends Shape {
        constructor(ctx, radius) {
            super(ctx, radius, radius);
            this.radius = radius;
        }
        draw(c) {
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
    exports.Circle = Circle;
    // Rectangle
    class Rectangle extends Shape {
        constructor(ctx, width, height) {
            super(ctx, width / 2, height / 2);
            this.width = width;
            this.height = height;
        }
        draw(c) {
            let x = c[0] - (this.width / 2);
            let y = c[1] - (this.height / 2);
            this.ctx.fillRect(x, y, this.width, this.height);
            this.ctx.strokeRect(x, y, this.width, this.height);
        }
    }
    exports.Rectangle = Rectangle;
    // Square
    class Square extends Rectangle {
        constructor(ctx, width) {
            super(ctx, width, width);
            this.width = width;
        }
    }
    exports.Square = Square;
});
define("Element", ["require", "exports", "Physics", "Shapes"], function (require, exports, Physics_1, Shapes) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    class Element {
        constructor(physics, shape) {
            this.physics = physics;
            this.shape = shape;
        }
        addForce(force) {
            this.physics.forces.push(force);
        }
        clearForces() {
            this.physics.forces = [[0, 0]];
        }
        updateDisplacement() {
            this.physics.updateDisplacement();
        }
        updateLocation() {
            this.physics.updateLocation();
        }
        draw() {
            this.shape.draw(this.physics.location);
        }
        // Static
        static circle(ctx, dt, location, mass, elasticity, radius) {
            let physics = new Physics_1.default(dt);
            physics.location = location;
            physics.mass = mass;
            physics.elasticity = elasticity;
            let shape = new Shapes.Circle(ctx, radius);
            return new Element(physics, shape);
        }
    }
    exports.default = Element;
});
define("World", ["require", "exports", "Element", "mathjs"], function (require, exports, Element_1, math) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    class World {
        /**
         * Constructor
         * @param canvas Canvas element
         * @param fps Frame per second
         */
        constructor(canvas, fps) {
            this.canvas = canvas;
            this.timeout = 1 / fps;
            this.init();
        }
        init() {
            let ctx = this.canvas.getContext("2d");
            let width = this.canvas.width;
            let height = this.canvas.height;
            let mass = 1;
            let elasticity = 1;
            let radius = width / 16;
            this.elements = [];
            // smaller circle
            this.elements.push(Element_1.default.circle(ctx, this.timeout, [
                width / 4,
                height / 4
            ], mass, elasticity, radius));
            // // bigger circle
            // this.elements.push(
            //     Element.circle(
            //         ctx,
            //         this.timeout,
            //         [
            //             (3 / 4) * width,
            //             height / 4
            //         ],
            //         2 * mass,
            //         2 * radius
            //     )
            // );
            this.addGravitationalForce();
        }
        start() {
            this.hendle = setInterval(this.update.bind(this), // todo: bind to `this`
            this.timeout);
        }
        stop() {
            clearInterval(this.hendle);
        }
        update() {
            this.updateDisplacements();
            this.updateLocations();
            this.updateDrawings();
        }
        static gravitationalForce(element) {
            return math.dotMultiply(World.g, element.physics.mass);
        }
        addGravitationalForce() {
            for (let element of this.elements) {
                element.addForce(World.gravitationalForce(element));
            }
        }
        clearForces() {
            for (let element of this.elements) {
                element.clearForces();
            }
        }
        updateForces() {
        }
        updateDisplacements() {
            let height = this.canvas.height;
            for (let element of this.elements) {
                element.updateDisplacement();
                // correction if element go beyond the canvas
                let x = element.physics.location;
                let dx = element.physics.dx;
                let elasticity = element.physics.elasticity;
                let ry = element.shape.ry;
                if (x[1] + ry + dx[1] >= height) {
                    dx[1] = height - (x[1] + ry);
                    element.physics.velocity = [
                        0,
                        -elasticity * element.physics.velocity[1]
                    ];
                }
            }
        }
        updateLocations() {
            for (let element of this.elements) {
                element.updateLocation();
            }
        }
        updateDrawings() {
            this.clearCanvas();
            for (let element of this.elements) {
                element.draw();
            }
        }
        clearCanvas() {
            // todo: define `ctx` as property
            let ctx = this.canvas.getContext("2d");
            let width = this.canvas.width;
            let height = this.canvas.height;
            ctx.fillStyle = 'gray';
            ctx.fillRect(0, 0, width, height);
        }
    }
    World.g = [0, 9.8];
    exports.default = World;
});
define("main", ["require", "exports", "World"], function (require, exports, World_1) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    // world
    let canvas = document.querySelector("#canvas");
    let fps = 25;
    let world = new World_1.default(canvas, fps);
    // start/stop event listener
    var status = "stop";
    window.addEventListener("keydown", (e) => {
        // press `space` bar
        if (e.key === " ") {
            if (status === "stop") {
                world.start();
                status = "start";
            }
            else {
                world.stop();
                status = "stop";
            }
            console.log(status);
        }
    });
});
//# sourceMappingURL=main.js.map