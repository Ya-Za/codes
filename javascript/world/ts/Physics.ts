import * as math from "mathjs"
import { R2 } from "./Common";

export default class Physics {
    location: R2
    dx: R2
    mass: number
    velocity: R2
    forces: R2[]
    dt: number
    elasticity: number

    constructor(dt: number) {
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
        let a = math.dotMultiply(F, 1 / this.mass) as R2;
        // current time
        // - velocity
        this.velocity = math.add(
            this.velocity,
            math.dotMultiply(a, this.dt)
        ) as R2;
        // - displacement
        this.dx = math.dotMultiply(this.velocity, this.dt) as R2;
    }

    updateLocation() {
        this.location = math.add(
            this.location,
            this.dx
        ) as R2;
    }

    sumOfForces() {
        return this.forces.reduce(
            (acc, cur) => math.add(acc, cur) as R2,
            [0, 0]
        );
    }
}