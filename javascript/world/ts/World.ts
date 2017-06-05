import Element from "./Element";
import { R2 } from "./Common";
import * as math from "mathjs";

export default class World {
    static readonly g: R2 = [0, 9.8];
    canvas: HTMLCanvasElement
    timeout: number
    hendle: number
    elements: Element[]

    /**
     * Constructor
     * @param canvas Canvas element
     * @param fps Frame per second
     */
    constructor(
        canvas: HTMLCanvasElement,
        fps: number
    ) {
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
        this.elements.push(
            Element.circle(
                ctx,
                this.timeout,
                [
                    width / 4,
                    height / 4
                ],
                mass,
                elasticity,
                radius
            )
        );

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
        this.hendle = setInterval(
            this.update.bind(this), // todo: bind to `this`
            this.timeout
        );
    }

    stop() {
        clearInterval(this.hendle);
    }

    update() {
        this.updateDisplacements();
        this.updateLocations();

        this.updateDrawings();
    }

    static gravitationalForce(element: Element) {
        return math.dotMultiply(
            World.g,
            element.physics.mass
        ) as R2;
    }

    addGravitationalForce() {
        for (let element of this.elements) {
            element.addForce(
                World.gravitationalForce(element)
            );
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
                    - elasticity * element.physics.velocity[1]
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