import { CheckerBoard, Shiny } from "./Surface";
import { Plane, Sphere } from "./Thing";

import { Camera } from "./Camera";
import { Color } from "./Color";
import { Light } from "./Light";
import { RayTracer } from "./RayTracer";
import { Scene } from "./Scene";
import { Vector } from "./Vector";

// parameters
let width = 256;
let height = 256;

// add canvas
let canvas = document.createElement("canvas");
canvas.width = width;
canvas.height = height;
document.body.appendChild(canvas);

// ray tracer
let raytracer = new RayTracer(makeScene());
let text = raytracer.render(canvas);
let p = document.createElement("p");
// p.innerText = text;
// document.body.appendChild(p);


function makeScene(): Scene {
    // things
    let things = [
        new Plane(new Vector(0.0, 0.0, 0.0), new Vector(0.0, 1.0, 0.0), CheckerBoard),
        new Sphere(new Vector(0.0, 1.0, -0.25), 1.0, Shiny),
        new Sphere(new Vector(-1.0, 0.75, 1.5), 0.75, Shiny)
    ];

    // lights
    let lights = [
        new Light(new Vector(-2.0, 2.5, 0.0), new Color(0.49, 0.07, 0.07)),
        new Light(new Vector(1.5, 2.5, 1.5), new Color(0.07, 0.07, 0.49)),
        new Light(new Vector(1.5, 2.5, -1.5), new Color(0.07, 0.49, 0.07)),
        new Light(new Vector(0.0, 3.5, 0.0), new Color(0.21, 0.21, 0.35))
    ];

    // camera
    // todo: how to use like python `Camera(pos: ..., lookAt: ...)`
    let camera = new Camera(new Vector(3.0, 2.0, 4.0), new Vector(-1.0, 0.5, 0.0));

    // scene
    return new Scene(things, lights, camera);
}
