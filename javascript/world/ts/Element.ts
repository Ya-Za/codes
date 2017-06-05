import Physics from './Physics';
import { R2 } from "./Common";
import * as Shapes from "./Shapes";

export default class Element {
    constructor(
        public physics: Physics,
        public shape: Shapes.Shape
    ) { }

    addForce(force: R2) {
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
    static circle(
        ctx: CanvasRenderingContext2D,
        dt: number,
        location: R2,
        mass: number,
        elasticity: number,
        radius: number
    ) {
        let physics = new Physics(dt);
        physics.location = location;
        physics.mass = mass;
        physics.elasticity = elasticity;

        let shape = new Shapes.Circle(ctx, radius);

        return new Element(physics, shape);
    }
}